Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636435DA41
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449136; cv=none; b=XEisPwNaMRGME0ghem3tiLHyE7Odc8D2nnWUToH/3S+71uOjrzoFw6FIEf2G35TlZs0PA69N5eRjIpY6e43tP+LWGPD1Sx6POM8GCckd18xIlPICScAoCVqA2nFVlNsaekjEC0oX85YPuERFhYtZIQCmUaKHWB9Obu+ZmWsxu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449136; c=relaxed/simple;
	bh=8mDyHhdc+T7R1gRGxWLBcuIyilWAAKo/Az8hAfYxtIw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwcPOR0uPCIj8xkT0fM4E+SUBrPsrhVwdvu3EHjpA0iZbc/SvfG6AxwAsugUGGSzk7MJln3xnR44i1im1qq0r9wS/3ekBrR9Fy/RH4EzBxmbtzd83ZUXxZydSGCB0F5aC9HH6ogZb1GSUHjAmroZ9Bf0/jwYJk3h+H1IY5p17lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQu3NM8h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQu3NM8h"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1114354f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772449133; x=1773053933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EdBAYuV99PQ9ijz1/mi/mW1QmHX8aIvY9yYgO2aQqlE=;
        b=VQu3NM8hOkubBDMUlRNYc7zArSTVVMTwKdKEK2pwCDWZ7TJpLhY033pHkcYeNq6Fv7
         jHbEEB9LlabKcnBpCQguwAAd6GFaAwiLlAdtDruCmZ/6HcSDPnSai7uhiFvp7noA8OXF
         Ahzm9hl8yqQbkqX/varR2cbcZ05GraEAsLr4SU7C76kLA9BzYRM+1R8NcRV+1G6z5F9J
         6jYmilUrFs7ZuMn+GuZnbrq5dL6HRJkMRpkz0IY2bWlBOD88zVxZSfvt5mt5FlWtYhaL
         Pb37U6VFcm3gT4XkrmsUntetWtwbLHTivZjHQJ/+Ekns+y2iGJ/3S8M1kmQxTKt3C5ea
         ZmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449133; x=1773053933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBAYuV99PQ9ijz1/mi/mW1QmHX8aIvY9yYgO2aQqlE=;
        b=LCxxqWUmBAMTYrEbWsVp42wBsc8Bdf5MojXclLNE9JmlPs5zbOMEgT0fKpKzpI3BQJ
         oPnhganWXRvxIIhhguTqHzn1pSwGoSTtM8wBoKmjgdJIQlg01zGKxuSQ/i5NU2zlwQiT
         YQsi4uTT+WrLCOE6OAMSkYesEaBBZfb7Ai+qd9G/htkqmsEm7tyzqB975vdOai65TShw
         F9vu34JEVN8gZqRK61jhxusipId6xZNFjvlhNxj5PBOcmiO2p3qVRrRioue9r03fjDCy
         VL9YLTaYRfK/r4ppSYouo0GAy60KTkHRiL8CQSrMX09UE6ipaCqc0e0w0Es+PUJ4IFtE
         tMhg==
X-Forwarded-Encrypted: i=1; AJvYcCXSWF6cOB+nilezxD+eqOo6g0/C1tPqZja/Yj09hwKsuajRBP2ZUeJNJ6TE9VyZD4VLDuTWDEysDZ1aEYIscgxBeiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABPaaDo5kJ/P+8TQLIUKp6ANK7G7VgW1uEaVYVsy5yzLU452S
	URZsWt6Na/OtlcePqKDV9wRN8VsxGCdwH632EjDv7KB22696OS5G5udG
X-Gm-Gg: ATEYQzwdvm2hKA864iMYtsc0X9xNM952PI/XOCfMKVL4DyUAQeDhLp7g+Y7C8/zqb8G
	jM3jre85Gdgd0ZaiXhX8TyFr4BExQAtkxBb6NerOTV1odKuPyuZHv5WrxLmkQiGPDelFLvzbxLM
	6aUTtZRZh/IdLiDGdaYzasnU72/GxQ/zmjKtnmrCTFQTKcgoTqZOWIB7VKhQ+sXTlQ3DrIp86UZ
	V6TVPOG5FVw2u1mXVTq0r0qhv5mQwwMRvafGJBFfC76vLstxHuPoeXYGvpSa8VkLU2vZwzZP8a2
	PCT7NCNHEK3GFcFJsAz1T+laKAuYHzQRE0YFUb7xtlqI8kq+AfZgw0D2buOmVPgbfExo6diRP8a
	6b2S2aHBRM9hnxuqYHWIEnoO1Ygryyyg79GwrAHOQQO0FDxjh50VdWjlKf4CZ218SEzDQdSuDPA
	GOIjNRo9U=
X-Received: by 2002:a05:6000:1842:b0:439:b62d:be99 with SMTP id ffacd0b85a97d-439b62dc8dfmr6773674f8f.58.1772449133135;
        Mon, 02 Mar 2026 02:58:53 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4e771basm11763426f8f.0.2026.03.02.02.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:58:52 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Mar 2026 11:58:50 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bot+bpf-ci@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-open-source@crowdstrike.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 1/3] libbpf: Optimize
 kprobe.session attachment for exact function names
Message-ID: <aaVtarHiOYPfe9Tu@krava>
References: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com>
 <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
 <CAOu3gNgRpMd9poZYibhGg+UfQXiHpB3ucnhvghoT0TF1rFfmPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOu3gNgRpMd9poZYibhGg+UfQXiHpB3ucnhvghoT0TF1rFfmPQ@mail.gmail.com>

On Fri, Feb 27, 2026 at 05:28:05PM -0500, Andrey Grodzovsky wrote:
> On Fri, Feb 27, 2026 at 4:18 PM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -12041,7 +12041,15 @@ struct kprobe_multi_resolve res = {
> > >       if (addrs && syms)
> > >               return libbpf_err_ptr(-EINVAL);
> > >
> > > -     if (pattern) {
> > > +     /*
> > > +      * Exact function name (no wildcards): bypass kallsyms parsing
> > > +      * and pass the symbol directly to the kernel via syms[] array.
> > > +      * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> > > +      */
> > > +     if (pattern && !strpbrk(pattern, "*?")) {
> > > +             syms = &pattern;
> > > +             cnt = 1;
> > > +     } else if (pattern) {
> >
> > When the fast path is taken here, unique_match is never checked.
> > The unique_match validation is inside the "else if (pattern)"
> > branch:
> >
> >     if (unique_match && res.cnt != 1) {
> >         pr_warn("prog '%s': failed to find a unique match ...");
> >         err = -EINVAL;
> >         goto error;
> >     }
> >
> > Before this change, a caller passing an exact function name with
> > unique_match = true would go through kallsyms parsing, which could
> > find multiple addresses for same-named static functions across
> > different translation units, and the unique_match check would
> > correctly return an error.
> >
> > With the fast path, the name goes directly to the kernel's
> > ftrace_lookup_symbols(), which resolves only the first match via
> > kallsyms_callback() skipping duplicates:
> >
> >     if (args->addrs[idx])
> >         return 0;
> >
> > Should the fast path condition also check unique_match, for
> > example:
> >
> >     if (pattern && !strpbrk(pattern, "*?") && !unique_match) {
> >
> > This would preserve the optimization for the common case while
> > falling back to the slow path when unique_match is explicitly
> > requested.
> >
> 
> I am not sure this makes sense, according to the original patchset [1]
> this flag was specifically tailored for patterns with wildcards where
> this indeed
> makes sense. in our case, cnt == 1 from the get go since no wildcards so this
> check can't ever fail.

I think the problem is that it could now pass for cases where
function name has multiple instances in kallsyms .. while before
it would be caught in libbpf_available_kallsyms_parse and fail

jirka


> 
> Andrii, Yonghong - any suggestions ?
> 
> [1] - https://lore.kernel.org/bpf/20241218225246.3170300-1-yonghong.song@linux.dev/
> 
> Andrey
> 
> 
> > > [ ... ]
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://urldefense.com/v3/__https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI2bmb4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuPuGlVKW$
> >
> > CI run summary: https://urldefense.com/v3/__https://github.com/kernel-patches/bpf/actions/runs/22503275616__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI2bmb4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuGeekJPd$
> >
> > AI-authorship-score: medium
> > AI-authorship-explanation: Comments are unusually verbose for a simple optimization, and the commit message is well-structured with distinct sections, but the iterative v1-v3 refinement following reviewer feedback is typical of human development.
> > issues-found: 1
> > issue-severity-score: low
> > issue-severity-explanation: The fast path bypasses the unique_match check, which could silently attach to the wrong function among same-named statics, but requires the uncommon combination of unique_match=true with an exact name matching multiple kernel functions.
