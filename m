Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8047C2FF;
	Thu, 11 Jun 2026 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781136783; cv=none; b=hRURh5J924S63zFx7ArEP8/fB5jhnWWb5lkasxOVlVXJRs/OOFA4VUnkARMQyvqqtAxwAejqEw7o+Pib4WY5LKygPiGxWjwuFcMVt5D1GYwcl9G+RLWqy4Dd646qZ8Y1BEQg8RWCjyPl9FjhC+Ye3Mg9skH1PKgEb7ULdFhx2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781136783; c=relaxed/simple;
	bh=nPSx0CplK9ApdBWEbx47YK55YKwhoRaKG1l+e5lb18s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrAtqKpj79C6rfkbWEkoVHreRbqV8nFIKREIEbCLyeD0Rx3FoDDtQroG/sgZz/27VKBOVafOtYrgON9mCPnDqKpxExhzxt3Vr6cL0fG3ATBkCz0YGvot3Mbf7BsPGFvcYZPn+wi/agoX4/6jkkkZrxaotg20rQKqIAgp05Yi974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id B88BDC197E;
	Thu, 11 Jun 2026 00:03:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 9A70B30;
	Thu, 11 Jun 2026 00:03:38 +0000 (UTC)
Date: Wed, 10 Jun 2026 20:03:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "open list:FUNCTION HOOKS (FTRACE)"
 <linux-kernel@vger.kernel.org>, "open list:FUNCTION HOOKS (FTRACE)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] samples/ftrace: reject zero ftrace-ops call count
Message-ID: <20260610200336.3c4d32c3@robin>
In-Reply-To: <CAE+C+DZXcQfyQt-UV2PRt0vVFJqCciW6QkyEd9FaJ8++B3M4Ow@mail.gmail.com>
References: <20260609004422.1239735.f6c06011af32.ftrace-ops-zero-function-calls-div0@trailofbits.com>
	<20260608210324.6af37e65@gandalf.local.home>
	<CAE+C+DZXcQfyQt-UV2PRt0vVFJqCciW6QkyEd9FaJ8++B3M4Ow@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A70B30
X-Rspamd-Server: rspamout01
X-Stat-Signature: 319ez1w31jos5cmb88i8yeqkb8uj3z91
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+slhWEr62lioUdr/bYwsWJ5/f6xEMYCgw=
X-HE-Tag: 1781136218-120135
X-HE-Meta: U2FsdGVkX18pSUu6bQkfDNlCbV1d4BlhqivQG5PMBTb6muRzPOmHCIQQ0yNeQwmlzVqHBfMv/PdS6axovdwhTsD/Be8eob6wkUeN/z/NS2DvOklTIQAVIEGqB9HngVv2WpSgfjaCkEmg3/xs/Vz6c5qFlEXqy+DIVPFh4KfxCFCEx8+NHa32h6SrUqWzvW3b3DN0ryiPYTuqvq31QyiiNym+DRR9e1kGIwUCNcLAcaW9shsi+aOUts3IopekGlR3uQIfMZcc878oe1NtBeFGFo4xmRiF0mLJPnP/EMmOZeHikMNrPACwi2kd5FzSsXSvhZH5VnCgvpeCl+MgcRTETqRsrNzijqPy3SKcWE6iQhPxrf3FqAkVZAIS5d08dkmy

On Tue, 9 Jun 2026 07:26:27 -0400
Samuel Moelius <sam.moelius@trailofbits.com> wrote:

> Is it okay to keep the same subject line or should I change it?

Yeah, and also note that the tracing subsystem uses capital letters:

  samples/ftrace: Reject zero ftrace-ops call count

But you can change it to:

  samples/ftrace: Prevent division by zero when nr_function_calls is zero

-- Steve
