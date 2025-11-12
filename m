Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9A29B78F;
	Wed, 12 Nov 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961882; cv=none; b=MU7Hynd0ouOPD59sbU0JJfEqEcFEUlzar0ITAwoFZfZ7HD9vICLWuLzio5O3GAVkQvIFkDmmN452ka12Gl0+O7MLAaiJFKvW1vpgplObs4j+uj4S1MymoB3Ucdyyp1VoE6H9LfkY7EN427V57oXsIayia6JgqoZQEt5Et2IOIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961882; c=relaxed/simple;
	bh=hlpKTafb8GK7Ub3ROyL9kf18Ly4pyM4eaJtlKKSfkCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYyYc+6KWttDHkRdYtYaAQugT6+tb9KYVuzUNTl71UYyJdTuu1SPdWiFZ6nW5uZyyw72IxqpTLoTSxymX1F4af0zHEmHPoEhh+kAMN5gZsMuwBpFHOhOFZeCQOvKI4WDzTthq69krflpUyUfQ2G+8AIKP61qdBnVqVUY426TjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 51A004CDC7;
	Wed, 12 Nov 2025 15:37:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 4E6732F;
	Wed, 12 Nov 2025 15:37:51 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:38:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Donglin
 Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251112103804.4a43591a@gandalf.local.home>
In-Reply-To: <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
	<CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4E6732F
X-Stat-Signature: s5fwrt7ws4byfa63c5z9k3dujotzoyjr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/7hBq4gRd/dHHQ3qVz2I9TBXY8zPd3jgY=
X-HE-Tag: 1762961871-310067
X-HE-Meta: U2FsdGVkX1+3fbg35+Tgwrit8u4tPx8LdgQC0mr0Kb3FDZVNCYptfQXaqHcySTqEXiiakz8TLtwci9hQup0oheVP71e2zKwk1CX5lAeTi1eOSx4C+BIWD+hsXA5o+9ueTVdv1lTSBVZqBxuL5ffVUgihJIX7OVS6COfmExKkwAQ5B6UejZdpidqW5axlilDbwVev8KBm4Afyw5PPtxer3RE5bEi+yKDYv2sj+gSKix2u8gepYD4E2u0ZmV2i4hGDIOjXTryxghntvRFt/06Vp791iMb+hEL9OEhKNChQvTCxt8KpOfuwZIg6MOQfkFak29pHIzC7qnB9q8UfCTj/to4rIqexDjdR

On Wed, 12 Nov 2025 17:00:10 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> I have a question regarding the behavior of the funcgraph-args option.
> 
> Currently, when the funcgraph-args flag is set, the function arguments
> are saved.
> However, when the flag is cleared, the trace output still displays the function
> arguments unconditionally.

Yes. The flag affects the behavior of the recording and not the displaying
of the arguments. There's no reason *not* to show them if they have already
been recorded. Recording the arguments causes a noticeable overhead which
is why it is optional.

> 
> I expected that the flag would control both saving and displaying the arguments.
> But it seems that the current design only controls the saving. This
> behavior seems
> inconsistent.

Not at all. The option is only for the recording. Otherwise, one might
expect than they could do the recording and then after the fact enable
"func-args" and expect to see them. That would be more inconsistent.

> 
> I think we should add a check for the flag in the display part,
> specifically before
> calling print_function_args, to ensure that the arguments are only
> displayed when
> the flag is set.
> 
> What are your thoughts?

Big nope!

The retaddr is different, as the information is somewhat redundant to the
call chain and may cause more noise then needed.

-- Steve
