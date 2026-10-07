Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C422157B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352578; cv=none; b=mMWGaTSK0sj6+abZtXk54v/KphYUA0u9mPCOjuxK9k3xoEU1Kdupk90FyHVA+u87PYimGkLSAwqtUYkm9uu7ExtUqBrpXGADnL1ky6cbWd4SnNidjsALwh2B8SeJ8U1ZIxd76r46mVJfm+gMCEZvy9X3xCx/pCcO7J8Tveit1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352578; c=relaxed/simple;
	bh=tN36ci4IovZxa177e6ZIcYcj/xxHlJyHAOWZAih5w4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzZ9OSFckLEer1oCRdM1DUELbkOoEmpkPhz43GhnMUTmBT+Edq8YK21NN8JB4TWnb9exBQSskX5jv90WG8JQLGPlkPRixRxY1PRnBYvMG8IacHWfhRWyP/nwE/RVuhEmlNc9lGAkDwS+smr+C/Roo7ch+Qs8JoZlaj70pVy5X74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=G8aed7PZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="G8aed7PZ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-48e94879f02so568840fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 22:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791352576; x=1791957376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXBQtCNU8FUq8Qg2PYU28JD3k9JJVaiWZX17kjJP17A=;
        b=G8aed7PZMlLTTD0ALVIFpoG5Hu8TLlFiy/czIU7jxg33jGDICKywZy5FVmAt5ON1hc
         TUC2cp+XnlRLR5WKuOkfjVQzscMLdGf5k3lvtYpT/Oedj3DbcWEg1T5vxcgeJvlNJS6B
         EgFoJBKeFOjETA4s//E2t/rqsOV+mdOn0b/7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352576; x=1791957376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXBQtCNU8FUq8Qg2PYU28JD3k9JJVaiWZX17kjJP17A=;
        b=Mx5azcj7Au7kegfKdEe9ZtCcjxfYSHy7WI1yCo6Dr5EKslUqNKcfJpcut80KDifeWj
         a4HaxK5KEFBELLkAzxzLpJUunnGY3uR6420tpMPenntE2aGtoBVCadgUeQUsIXUueTUo
         P3SkTUk6UqUXcUHSgJEQrEmoSpDhEXbncuprWSpQ0KFdl7CCJpE5DQ1vNnmRT2pqHBVX
         HeJUHefT3A6f4KUdFN2cdAWil3G7QBt1m33TPqyqdA7FI0mT/olYtkgZIryJlt/DMDi6
         gRZEFMHskfrNfirhAnW60COhcoeDGQ/Ms99QIhT3wCEYlcU995XXlkSp6tsaeKm+cTXx
         24Vg==
X-Gm-Message-State: AFuF++nZmPhD4XQlLBawjVFYmoJf851IRP//xhUy3bK7G0MAVTVoVlBz
	gb0Z7BBg8qEGWaAdeuugXJLrofaVvEWHi1xP2i+fmg/LttjF0FmMzHuLltPd7XcN2MY=
X-Gm-Gg: AYBFou3mNemuSRcwDfppT92DMwHbzLLDmUE1SzXYl373dWAwi960acmONNoiJkPIGBg
	tHQc+dDqwMFugR3oYtVW2AVQaMTrQEHjXIS66YQJRmYyiwPxUmZPD92hgGXd6X0slaaQiHRmpG5
	hYB8yvk1A0jjnYPQ9vxSBgduAgOQpIHQUoNB5srelCFCxnmWrRMHAR0QulceFnIeYvkFas2uTBh
	2ftd0Wg7pwpay8/rNNOk+9X7ZqWniHjx2TpIiGJKRcrTSdPwLf0oYZ6vuw45oQZatYWv7r+loZR
	E3wdpjwlNthHJ+HC2OVBbIFr7AW46h+AGJ0VtBrwm+qC3b/h9dORGj176MpGRkeky7JvG4vxY2N
	9mfMGGMQHjcY0j4ZlaIDjeUyfjeqGiUqCkyvwrmeFcgVzl8cwVH6bVDMdzsQUMsNkfHAw3V3gYK
	kvfqBh03mwUcvG98uDH9cTp0GEw7D0TbD9h4XxR96gcsxnRCtlNQEKkYNTEbQHJPn+mixq1qybD
	trzBRb5wPPAag7QfuYthkglt8OU/V8Wg5rksSfurmIgPc5ECd0EwxWxs27kUE1e
X-Received: by 2002:a05:6871:2b16:b0:49e:3edb:987f with SMTP id 586e51a60fabf-4a2594c418dmr1203497fac.11.1791352575733;
        Tue, 06 Oct 2026 22:56:15 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2571cab91sm1335158fac.11.2026.10.06.22.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:56:15 -0700 (PDT)
Date: Tue, 6 Oct 2026 22:56:12 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, outbounddisclosures@openai.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before resolving
 .function
Message-ID: <asXe_NWiBtGDXZVN@com-75606>
References: <asXAxf0edslJI-Ge@com-75606>
 <20261007055225.32DDA1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007055225.32DDA1F0089B@smtp.kernel.org>

On Wed, Oct 07, 2026 at 05:52:22AM +0000, Masami Hiramatsu wrote:
> On Tue, 06 Oct 2026 20:47:17 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> > On Wed, Oct 07, 2026 at 03:44:20AM +0000, Masami Hiramatsu wrote:
> > > On Tue, 06 Oct 2026 15:51:12 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> > > > perf_trace_event_perm() allows tracepoint counters that do not request
> > > > PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted,
> > > > disabled event with exclude_kernel=1 can therefore reach the filter
> > > > compiler even at perf_event_paranoid=2.
> > > >
> > > > The .function suffix accepts any field of sizeof(long) and resolves its
> > > > operand through kallsyms_lookup_name() and kallsyms_lookup_size_offset().
> > > > The success or failure of a numeric filter discloses whether an address
> > > > belongs to a known kernel symbol range. On x86-64 this can be used to
> > > > recover the randomized kernel image base. A named filter also exposes
> > > > the resolved symbol range through the counter when the tracepoint field
> > > > is controlled by the caller, as with a syscall argument.
> > > >
> > > > Pass the filter's perf origin to the predicate parser and require
> > > > perf_allow_tracepoint() before resolving a .function operand. This uses
> > > > the same sysctl, initial-namespace capability and LSM policy as raw
> > > > tracepoint access, and closes both the numeric and named-symbol oracles.
> > > > Do not change ordinary perf counting filters or filters created through
> > > > the separately controlled tracefs interfaces.
> > > 
> > > Good catch!
> > > 
> > > >
> > > > Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: Codex:gpt-6-astra
> > > 
> > > nit: This should be 
> > > 
> > > Assisted-by: LLM
> >
> > Didn't know there was a change of convention. Should I send in a v2 or
> > it will be picked up automatically?
> 
> We can change the tag when picking up, so you don't need to resend it only
> for tag update. But for this patch, please update according to Sashiko's
> comment.

Thanks for the explanation.
I just sent a v2: https://sashiko.dev/#/message/20261007050315.65139-1-kylebot%40openai.com

Best,
Kyle

> 
>  https://lore.kernel.org/all/sashiko-outbox-162502@kernel.org/
> 
> Thanks,
> 
> >
> > Thanks,
> > Kyle
> >
> > > 
> > > > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > > 
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Thanks!
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
