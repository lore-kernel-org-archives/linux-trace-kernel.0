Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE2357D18
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859157; cv=none; b=fEIKzBTtbpVAfLEetutRf1A3VwS0B2Gs/chIHUGMy+U+tXtoWfxAsEryz6w2V/0TEIdcjymAJ/YdyZvO9ZpfSbF3wwNw5Mee/S9Nryr2jvVSjpw4RTMp+ZqdlIJBs5Bxekk1sMio4SWcNfHk56TmCXGxOWP/Gw4UF+ZntFqFPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859157; c=relaxed/simple;
	bh=DC4BFkJWg/X0N+gsnTj2MEDN8HTfEUDSa8HvjoV8zdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5v2rl8wXiCcYmxicM6tzmQNACevkBTSo44WIO7kvnPuXn7k0k/YR9mP0cMYxRLweZJABI1vGbnNAOmNMryuZYpMNcKYt/AEVADWVtqBD+3Rpl6nj+VMCLEz5IbRR4gtPSSVIraXsZ+yN3rCxHj8vLJ4yvtfpfD3tA/k5UXj1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2twvMfLk; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2twvMfLk"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B7F23A01AB;
	Thu, 27 Aug 2026 19:32:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2D2FA20025;
	Thu, 27 Aug 2026 19:32:26 +0000 (UTC)
Date: Thu, 27 Aug 2026 15:33:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260827153314.77218528@gandalf.local.home>
In-Reply-To: <apBhLDTEa_3yYZP5@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
	<20260826094528.3738023-2-vdonnefort@google.com>
	<20260826095947.4FF8B1F000E9@smtp.kernel.org>
	<20260826103736.2b55b464@gandalf.local.home>
	<ao8TQ-SvhjYgy43-@google.com>
	<20260826143123.1b3e3854@gandalf.local.home>
	<ao_Zu0ThaWThj9YZ@google.com>
	<20260827091541.5d03e33c@gandalf.local.home>
	<apBhLDTEa_3yYZP5@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iozobjrey3g5jkcr6doixc3yfc95o3fb
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2D2FA20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/UL7GAVv/ig0hpN7SedXw5ufSnN8g2eg8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=MYsZyEV3Fytys/Ah9WMeAgkFvcSFYF6AgdtgppHiN9o=; b=2twvMfLkTLfn/iPCN6oUIrQNs6x8lKnLHuGn8y3mDdA+e6wgb6TjoziQJBBCESeYrRPVeTnb1vH8Y7g9JBRXs9P3XDTxLjGFpSQi6ca2u83UnFKBmlTTWWz2hjb1f4dMAImzsVfxDf4n0L9cHLTFXJAp9xvWFdtKBvnGcGpeHgI=
X-HE-Tag: 1787859146-349834
X-HE-Meta: U2FsdGVkX1/GmrrD//8AixNjFF9tdsXA7dCKEscMUFkSLy6gS8PDqvnn5S49OXtse0xXNKVmeWGim66DGWncgyJf7C4Unq/HKboWnYNAKPV7zgfF+2FjuwlLok2PXRLlG3pceiPaQZXoZ3AYZUpjI1kcAoFqzbtaBcSSuY6Z0XiWapuN133I6LDvfoTKCR/Z0QzkDLnF17bdAkcLdqw6sD9pYIGdKYADQaCt4ztmtbgudLihiOGiEEve8zDsTVGVMam4KIVl5LTwPuhhgPQhb8I9QUj3c/HAZ6MFedkXSCSELzlN30YzTv+y9M0wfVqy+ZcsaxhPEo7cJjAhqubIatswTEXSjl6k

On Thu, 27 Aug 2026 17:21:39 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Thu, Aug 27, 2026 at 09:15:41AM -0400, Steven Rostedt wrote:
> > On Thu, 27 Aug 2026 07:31:23 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> >   
> > > Looking at the function again, shouldn't we add !rb_is_static(cpu_buffer) as
> > > well to the full page test?  
> > 
> > Why? 
> > 
> > -- Steve  
> 
> So that the splice can make progress when the ring-buffer is presistent or
> user-mapped. Or do we say that's expected behaviour? 
> 

Ah yeah, I see. Hmm, looking at the code to see how this would work, I
think I found another bug. Let me look deeper into it.

-- Steve
