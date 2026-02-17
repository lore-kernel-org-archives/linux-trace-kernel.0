Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E3309F01
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365912; cv=none; b=ppWN7KS+YmrBzi1QkUGiWxrRK5HiKgH2NGexpk7iNbNCTNMJlqA6Jzp5LkhVO4AIQsZUNy9xHOLmDwA9K8pREEXfOLKU3V7t1HG9Hz+K/Z3n43lITSZYfCHvs2P7gb46+J3g0jgVr7mdRVGGujbo2CEsAhd0kVFpohH2/KsyPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365912; c=relaxed/simple;
	bh=eRJGi/3EYvgsGuMw1/YWY8Hw9h/WwehRbzwbSM56p0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VICX9lMM08xvSmkZpjtpYs2a550jAKRVkfoL1E3FMMl4n/AH5lbMeTlH6n5Ab1ExQ8eFcbm/g8sP17yDCe/BkED/g3fVjGdk5dw5rGqeuRhfJ51zte1Vx7YkhDPx97n6FmRmpkrb8KMr3ji+vJ+AkYzSJVaxxjddt+LwaE01zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcI9987g; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcI9987g"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4833115090dso42344235e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365909; x=1771970709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pb9TCnVBIZiNkTZbCbry7FrvZQcTN63m7K6gzOiYf58=;
        b=EcI9987gTm7BTt0PGUJM5g79UR+3Td5Wx1IPiv6zE9t5lxMLDyfDpMB52h6Io+Ox1S
         lnW4n9vmqd2T6EpaYbhTyYrezW/sqB0dANvcW5p9KmWdOhukhPhGHMsZncluuomCYapV
         zwe0YO+dWPhmzcrJGSSEfTXlmlYxq2WBTLURQCPiOZ6iOvnh0G6lkvfwUTn57bDjh463
         XBQ7l68kLMe+Nm8fabl+pkWhqxPRtC/mGBhPOp2tUpDBYT3vIKDeisoLroC0mvui5C0/
         +p9hOBKnAS4ehLcMHykGB0wwbdgQOTef00OlW2IKEkbiJ2T+SOxaBzZXCPFZgipx2bKu
         wlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365909; x=1771970709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb9TCnVBIZiNkTZbCbry7FrvZQcTN63m7K6gzOiYf58=;
        b=Ze/NIM6rw6PsqZaepEoy3+QMTwAIdB4cmp6kUJd+MBt7cXqi6iCFGV5aIZ6StILvQm
         ANXvWMAfz5pOoKeicbVyviFpcgKzFCYyJ1Se8kK5iAbjv0wxnKGqbEmFqJ2XtjSTbvjS
         2uE67+WhXE8asI/pFOmkkCeaWrOutOo/F5fVVxwZvtGUYXRgshE07a9D0zEtv00UDrht
         z6HtzWftK0L9gpYWG0RDHsfE8TsM3x84tfOiBFA6Wh++/sb35VFw5SBAZSiV6PYzZn1V
         MSsP0QQFxQbeEykaa4ETSyJ6q0aKZiQvK4fgWSJo1pdxheVAOggVkzKjZnm1wAdGvHNT
         xOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnTTdp1/6w26U6sbSSFNcBmUh6+z4vPhrmpJeohKqN9BTbPFP/V83WQqNSwd+qXCkZozfsS0Dmy6R0+Jcj05gZoSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsLFBpjMfWW8mLmrKN5QntCb1wCc90TFxaFZej0jW1jooOJy1
	KHVzMjKPoKPW6O1RpjPW5Ony5r1nRDwKaBuHAJiTf7tiGkVW8k7u0D/m
X-Gm-Gg: AZuq6aJNF8XbJeIP2kuCUne+6ZAskTTPdn5iem4R3xbrgY7MAec4BkL9ukezw6RSi5B
	lrRaIQjL2H2UFqpkHumceUxrtop1716dNymZ+oSAC3QbD2GCxBX8Yue6duVegODp5zwNCGjGgDQ
	c2gVQsWnCG8jJaHF0gOjkuph5aMbEHbiKvu6La3M4f4mK5Yc5F02Obt7sciuVUSV1AuvIpVaDup
	97n/hCYxmFH5DhKrgbf8jep0nlRB7TrhwekhUpS5Z+LrnRsKAIvQZrMi5zHxMAemHh2mZh7QFJB
	zw+TkhHEEp8KDQk71fYnjJNwpkMM/OCHP0Qgr6dWKOCP0u0qZ9iMxHjiXWxT3zZmJkkjxHAPwKe
	6XdcPhpDQIYcAviBIf7kiGUwK3dq4SVpRbDryoiBy0pCjxW8WXbKAaWjvBTGjryH6G3QkoHNTWt
	C0CVEOS94Nk0AQkSUewoGfE60s9Zi8JQfYsZP/6v66St8=
X-Received: by 2002:a05:600c:5295:b0:483:9139:4c29 with SMTP id 5b1f17b1804b1-48398a48450mr545325e9.2.1771365909130;
        Tue, 17 Feb 2026 14:05:09 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd259sm39593310f8f.24.2026.02.17.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:05:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:05:01 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
Message-ID: <aZTmDU9nKhYsKEKd@krava>
References: <20260203093819.2105105-6-jolsa@kernel.org>
 <9df0acf7860b7e4a90b3e93e2d6924e9bad35fe307bef0bf9b50f8afb5cccacc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df0acf7860b7e4a90b3e93e2d6924e9bad35fe307bef0bf9b50f8afb5cccacc@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:13:53AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6b62b6d57..fb52ba2f7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -25069,7 +25074,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >  		return 0;
> >  	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
> >  		return bpf_iter_prog_supported(prog);
> > -	}
> > +	} else if (is_tracing_multi(prog->expected_attach_type))
> > +		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;
> 
> This isn't a bug, but should this branch have braces for consistency with the
> preceding branches in the same if/else chain? The BPF_TRACE_RAW_TP and
> BPF_TRACE_ITER branches both use braces.

right, will add it, thnx

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit message contains natural colloquial language and personal attribution typical of human kernel developers, and the code follows established BPF patterns with typical human oversights in style consistency.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor coding style inconsistency with missing braces in an else-if branch that does not affect functionality.

