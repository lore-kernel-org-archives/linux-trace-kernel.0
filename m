Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532B47424F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069442; cv=none; b=lHRKsW3JRK4PMm4wdjzdo32byxbbbhEKCbxooLPpjvK93hBQBY6gWp0euqn23mKdnl2SCSw97yNjlk21l0d3If/ish4orq2L1LVP0H8+3LmUEUVzIy4h0rTbSeqvPWomQ9jDAei2rGs05R78FUbT3xgihiduzdrgLY3FZx/db7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069442; c=relaxed/simple;
	bh=Ej1OKIzZ624Ui5Xsq/EoGFTv2e1GKHnjXgYOyjTcjMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq7fVUKJHjjA1OQWrXZQTSOIV8NSNRy7ciJRlArH7TtKHyAb0cgZFal1tqPRi6g8xJbmEKPB5Idj1qnLJgLpI3r6Y+5sJ8HPA7Xdb/lrBlAVlOu4Z01l57tPggvsiIH2QIUIHm56qb8oAABR0UyruonTOvWna6cO7vCRPTUC/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=62zlIpNa; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="62zlIpNa"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 6CAFE8013E;
	Tue, 18 Aug 2026 16:10:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id A0DC820025;
	Tue, 18 Aug 2026 16:10:28 +0000 (UTC)
Date: Tue, 18 Aug 2026 12:10:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <include@grrlz.net>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled
 knob
Message-ID: <20260818121025.187b1a1c@robin>
In-Reply-To: <786EF401-1ECA-4ACC-BED9-764ADFAB9087@grrlz.net>
References: <20260818014920.23870-1-include@grrlz.net>
	<20260818020119.2DF141F000E9@smtp.kernel.org>
	<786EF401-1ECA-4ACC-BED9-764ADFAB9087@grrlz.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A0DC820025
X-Stat-Signature: s1u3uhimb8u4ob7bndaaofmkx6p913ti
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WJJyPpIkXj6NRdFovX6exs0VdDB7pwZ0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=fvAB6j1CaCVhBMde1WLdjwqamICgRD3e/AUgxO7mOGs=; b=62zlIpNa+zMIbwf5/zkFNaOHxYOm4tgugdwsgcCS0sm+tI84tMKhwQyxgn3lJAIdMEb2/J/mzCyXpKaao4X5wzZMViK070C7CI8StXo8jC6fDQNu8aCCHZXweYRpdlh4skoy61uoqhtSGi/t93WA3r9pWKU5v+390C0sesW7Mxo=
X-HE-Tag: 1787069428-806084
X-HE-Meta: U2FsdGVkX18GK76fw2cBnoHO6hgWUCaFrbiIRziIMHmC6B0/YumrHP07LbFQ+gb0Bb2i49FfTI5rz8p8AK/0qUW15gw4dHBs9yJbRdEkopUDwiwhqsQ0uWDIzAJ2DkOto3I6S+XYlBhuf58RqOfY/IPZBApqULqNk/B57iNOKNCPzD/vFUqkZS3kS76gSP45tIFvgoZ6+xd04Ww9+0WvY6Cxo5Sm9DcCooExv/31sC1+Y+cf9o6RBecK0RVVbjCkVlgXGQ8oj8FtKgPnFAkerm/TtFRKC1pS0AbLbuhwvULI7qf9+Bn0ag+Y5gicSy/ASXfAnxJhCkw4qARKZRtRhptIY8kkPZmLlKud+Xd4+2v4inMqhfgG5qVEcjUBiKm02Sxkp8w8qtlWeeK3T6lioPBAp7oL85k8dBTh/F6TUf1vmFlzBltPPUGHV4kwuFKES7qK7B35B0GE9WydUTXRCA==

On Tue, 18 Aug 2026 16:17:20 +0100
Bradley Morgan <include@grrlz.net> wrote:

> On 18 August 2026 03:01:18 BST, sashiko-bot@kernel.org wrote:
> >Thank you for your contribution! Sashiko AI review found 1 potential
> >issue(s) to consider:
> >- [Low] The 'enabled' debugfs file is created using `debugfs_create_file()` instead of `debugfs_create_file_unsafe()` with a `DEFINE_DEBUGFS_ATTRIBUTE` struct, leading to redundant proxying and overhead.  
> 
> +akpm@linux-foundation.org 
> 
> I hate sashiko so damn much, best to wait for review!

I found sashiko to be extremely useful. 


> >[ ... ]
> >  
> >> -static const struct file_operations fops_kp = {
> >> -	.read =         read_enabled_file_bool,
> >> -	.write =        write_enabled_file_bool,
> >> -	.llseek =	default_llseek,
> >> -};
> >> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
> >> +			 kprobes_enabled_set, "%llu\n");
> >>  
> >>  static int __init debugfs_kprobe_init(void)
> >>  {  
> >
> >[Severity: Low]

It is even saying this is of "low priority". That means it's more of an "FYI".

> >Will this lead to double-proxying for the debugfs file?
> >
> >Since DEFINE_DEBUGFS_ATTRIBUTE natively provides debugfs_attr_read and
> >debugfs_attr_write operations that already include debugfs_file_get() and
> >debugfs_file_put() protection, passing fops_kp to debugfs_create_file()
> >in debugfs_kprobe_init() will cause the debugfs core to wrap it again:
> >
> >kernel/kprobes.c:debugfs_kprobe_init() {
> >    ...
> >	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
> >    ...
> >}
> >
> >Could this use debugfs_create_file_unsafe() instead?

As this isn't a critical path, I don't think we really care here if
it's wrapped or not. But it's nice to know that it is.

Anyway, I'll let others review this, but it looks fine to me.

-- Steve
