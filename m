Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420AE45516A;
	Tue, 13 Oct 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883155; cv=none; b=sse+8ZaBtMuCiyvYzP4K5VTrwLsG9JtIdSSM3lxnn2ZAtKo/KKyqX+hWs2XQ+HlMdSKpI3JRjt8fNO1bmMb2gDDEHijiATd5m+T1dUPTEUXzy85nOdBJ1V/Kwr3j6Ju1cG49vz317YIVjw8cHTbFlwih6jecwNAOtUAS2TOAFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883155; c=relaxed/simple;
	bh=gEDqM2iaB/iy0jV6OeA63adVFBP0Bz/0BRTlXlf/JD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqn5aVPT/LCDah4Adiqj2mi6ogNW29FR4eB9n31GOK4ZfECVUAQS2QcMtvx8kBOkAs7Rxm3UHZv5CX1bvEkSgKOQW1cli82j1Hxx7S00bMc+FY+NGD/XrfdvDy/NIAWKgOk6K2GlnH/hsERvDmQCFDBTyUmiahPzCsUIJ0ZELbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2UwO3YD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2UwO3YD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6991F000FF;
	Tue, 13 Oct 2026 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883153;
	bh=o34QbmfjAAT4ADTs3ougGRHwgWEvqXtag3mgOn6QjeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m2UwO3YDjCMptXLJ91xmtq0Uz3H2e0P2q7o07vCdR8ZQWwbh5UMqcSegN3OaElwbj
	 sJDc2sQVy8Vf7g3L3Juqj7X0GJnJX/mnv9Fqb1RVNST5uE3wJsQAwUIe3ESGi1RCBX
	 ZrZWQ7Jvb3OfezBGNkjAkTQIUKyQFnvfek+6a5mxyr2dv+za67/AebtkRs7513HzxC
	 rL+fv7Hy+JZSj3yL3lwxfKOgo1G840tavCOAt7rUmPzEsymeaZMQeGwxuN2Fa92bot
	 8WK6Vb48cDJgLTUzatktZBC1dJZe8N7wrrXnJ5E3ctRJrCFSSXXp8lbrJQZqbc9ELQ
	 WD1zyhe2PgWCA==
Date: Tue, 13 Oct 2026 10:19:10 +0100
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/histograms: Reject non-stacktrace fields for
 synthetic stacktrace fields
Message-ID: <20261013091910.GD199624@google.com>
References: <20261012155805.1103972-1-lee@kernel.org>
 <sashiko-outbox-168379@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-168379@kernel.org>

On Mon, 12 Oct 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] tracing: check_synth_field regression for __bitmask and stacktraces
> - [High] tracing: arbitrary memory read via scalar to string synthetic field mapping

Fixing now - v2 to follow shortly.  Bear with.

> --
> 
> commit 4813d717e995df13871068dd6fd996711ca8965d
> Author: Lee Jones <lee@kernel.org>
> 
> tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
> 
> In check_synth_field(), when a synthetic event field is a stacktrace
> and the histogram field is not a "long[" stacktrace array, validation falls
> through to the generic size and signedness comparison.  This allows any
> 8-byte signed scalar histogram field to pass the fallback check and be
> dereferenced as a kernel stacktrace pointer.  This commit attempts to reject
> these mismatches by enforcing that field->is_stack matches the "long[" type.
> 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 8af97fd4ee2d5..b09f5043e1543 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -3946,7 +3946,10 @@ static int check_synth_field(struct synth_event *event,
> >  	    && field->is_dynamic)
> >  		return 0;
> >  
> > -	if (strstr(hist_field->type, "long[") && field->is_stack)
> > +	if (!!strstr(hist_field->type, "long[") != field->is_stack)
> > +		return -EINVAL;
> 
> [Severity: High]
> Does this heuristic falsely match the long[ substring in __data_loc unsigned
> long[] from __bitmask and __cpumask fields?
> 
> If is_stack == false, this logic seems to falsely reject valid mappings.
> 
> If is_stack == true, this appears to bypass validation and allow a 32-bit
> __data_loc integer to be passed as the field value. Could this 32-bit integer
> then be cast to a pointer and dereferenced in
> trace_events_synth.c:get_field_size() and trace_stack(), potentially causing
> a kernel panic?
> 
> > +
> > +	if (field->is_stack)
> >  		return 0;
> >  
> >  	if (strcmp(field->type, hist_field->type) != 0) {
> >  		if (field->size != hist_field->size ||
> >  		    (!field->is_string && field->is_signed != hist_field->is_signed))
> >  			return -EINVAL;
> >  	}
> 
> [Severity: High]
> It looks like this fallback logic fails to reject a scalar-to-string mapping.
> 
> When creating a dynamic string synthetic field, its size is set to sizeof(u64)
> and is_string is true.  Because field->size equals hist_field->size (8 bytes)
> and !field->is_string short-circuits the type/signedness check, will an 8-byte
> scalar successfully map to a dynamic string?
> 
> If an attacker-controlled scalar is passed, can it be cast to a kernel pointer
> in trace_events_synth.c:trace_string() and used with fetch_store_strlen() to
> arbitrarily read kernel memory?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012155805.1103972-1-lee@kernel.org?part=1

-- 
Lee Jones
