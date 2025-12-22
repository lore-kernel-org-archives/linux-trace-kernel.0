Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04130B513
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390594; cv=none; b=AapCJU4gDlcF1ufAt/KwvOFW7UCqjM11xb0rKD7PhzR8LoZeM3S4rFnYtH+rKBmyXXCBCG8FKAaNOd48cun8ePMpL8Tk+w7gOne4EJc9zNwrx965d4RQBh+tSXPPisAOJlhAr46YHBWb7R4NduKjpQhqmd651xXNKIpEqvce3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390594; c=relaxed/simple;
	bh=u2adXUBp2SeqqhB2kVGsCuKLjCBT5Qy7mm7YBd0yUcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWBeEr+Hc+pTUR/U06/dZyixFmDRuC8CmbQwKZ7WwBQF+y/QKV05g4faQV9vHYhMmu7+Wkjzeao6NKUm1O9001V+8zbqjEFAB7jBG/YtT5MKpzZVUBTpchbwy+UlqH8eTfuQiRL5JUsU3GBk67vh9GBEpqq66iDcGpsFlJJ1qPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKoc3m1q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKoc3m1q"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3028790b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 00:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766390591; x=1766995391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S17DRa2h+/R73ieVf7xBn3BELlMa+wdtLCYGLGZ2+5w=;
        b=SKoc3m1qSkuZEhrVHBVp6zEJey76VJ5cNVjDB6OEJVZZJD0Edgerzrmz1OkNExsZQr
         CxC+kToJA7e96B6W2/XOdWvWsFh69ceD9AtVtvzyItZG4nR42pHbS/xodFNFn9IKem+Y
         GrkwFGjZBf9HkCgQIrEU89XR4xoTJXkMfc4XhsVGbOV54hZit6wC2Eif1J91ZPRmmcKp
         z5cjsdBNOH7k4tXV29Wol3YabkZ3EKhEPyLXMXxYqkQCsK6ypbnRRW0shUlAGTxcJ8fO
         KOdF07N7IVAcN9uMoUMaj4ZQk+K+aw6ITG03vojdsKu3q7Ft8ANBAe3ilrk1qllvR0Zk
         gUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766390591; x=1766995391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S17DRa2h+/R73ieVf7xBn3BELlMa+wdtLCYGLGZ2+5w=;
        b=koOHiLl4j2RvOMwGgxZueErEWA/BctS+ErNYmgYVtSWuPYOBY5qSvtkdgjqllNXqnO
         QdHFELCQLzq23WeXE4L5cFPO/V9sBb6TdcCRoYnYkp7MEkJMi8Gz+ok6FMdhZ2/XuyHk
         YwRkiyMyYjSxCfVF0tHxK18dqBAkUCCQgpPkwovIXmNDs5Axem2FYmxEMFygAuwKiL65
         yixdVpmLwWJMdDjgNW1j4IUSCDl7Vd7xp01pHzphhQmXr9R78POOBYuTq1Hs2shnqIQK
         yNB6tUTnMGNFo82sEt6BGQgqvJgz8zsamEh872JHnvGI2Uuqqjnr4FQu5hp/ygDD+j4F
         rN8g==
X-Forwarded-Encrypted: i=1; AJvYcCX0Tgc1sB3I50cDxHr6xDLE8TnCdwXytz/4P8iFVHenGD25iRk87LO7scWVjcDHtzLf2Wbb2NvPL5PWWEz8AL26zu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4czNmn2cGaZw2kXVh+9U67i5FfRrejn7NTNjwdfDTzVZrjqQ
	csJXl32iuGOYOZBWuGruelAeIbsXXcxR1d6AyV7RAmNOQM494w3B1YVs
X-Gm-Gg: AY/fxX6bN5qDoTBvwIKVcu4Xy4S/TSGxnVtTQss6yQp6hnXtoCx+xpw2eRSHfTgvuON
	aopp/KhtqJFjbR+iYOyUzawPbTcDgaGedeAazvecTZ294rY+2AIiz5vmEUVetXmbI1Iu4muWUAk
	xz+f0TmtXLvlIF7Mx1RRZV4+MRnhRiplvjtuofFVcTsuvkNR+8krsN+IZn9LOodK92hfdNKdIta
	fVOBxEERNN+BGONZugT3D2Td6i7o/JfDyuf1LnLKwIYgPHnGjXU4gGOGf0Z4fBZxwOrB/mIPtOS
	VTzRHAX6MkOCY8zZBGexEjjKPY+LJ6yrvI8ywAtN75grP5x7Ea6+9AVeKiOfWtTnadYuf6rZVQY
	URuv6n3/lclmtiUiuyXzJzMyY+w8XusyJ2hgabsHaehq24ZHo60LQTJYRu85PHaFUM8iINWZHlT
	7b1O2A7AizMLg+J4138D5MHuObITLDRRNyZFU=
X-Google-Smtp-Source: AGHT+IEtrG0VqTiNJPqK10jmschrRXZ/4HelRXlYEPIKhnktqJ/0oCYzH9sApYMw5ja3HXigyYybeQ==
X-Received: by 2002:a05:6a20:4311:b0:350:f9c5:f90c with SMTP id adf61e73a8af0-376a81dcc1fmr9044567637.27.1766390591415;
        Mon, 22 Dec 2025 00:03:11 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961b4d0sm8408044a12.5.2025.12.22.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 00:03:11 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: menglong.dong@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing.root@gmail.com,
	liujing40@xiaomi.com,
	martin.lau@linux.dev,
	mhiramat@kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
Date: Mon, 22 Dec 2025 16:02:53 +0800
Message-Id: <20251222080253.2314895-1-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <24197762.6Emhk5qWAg@7940hx>
References: <24197762.6Emhk5qWAg@7940hx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 09:57:37 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:
> On 2025/12/18 21:06 liujing40 <liujing.root@gmail.com> write:
> > When fprobe is not available, provide a fallback implementation of
> > kprobe_multi using the traditional kretprobe API.
> >
> > Uses kretprobe's entry_handler and handler callbacks to simulate fprobe's
> > entry/exit functionality.
> >
> > Signed-off-by: Jing Liu <liujing40@xiaomi.com>
> > ---
> >  kernel/trace/bpf_trace.c | 307 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 295 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 1fd07c10378f..426a1c627508 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2274,12 +2274,44 @@ struct bpf_session_run_ctx {
> >       void *data;
> >  };
> >
> > -#ifdef CONFIG_FPROBE
> > +#if defined(CONFIG_FPROBE) || defined(CONFIG_KRETPROBES)
> > +#ifndef CONFIG_FPROBE
> > +struct bpf_kprobe {
> > +     struct bpf_kprobe_multi_link *link;
> > +     u64 cookie;
> > +     struct kretprobe rp;
> > +};
> > +
> > +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> > +{
> > +     for (int i = 0; i < cnt; i++)
> > +             unregister_kretprobe(&kps[i].rp);
> > +}
> > +
> > +static int bpf_kprobe_register(struct bpf_kprobe *kps, u32 cnt)
> > +{
> > +     int ret = 0, i;
> > +
> > +     for (i = 0; i < cnt; i++) {
> > +             ret = register_kretprobe(&kps[i].rp);
> > +             if (ret < 0) {
> > +                     bpf_kprobe_unregister(kps, i);
> > +                     break;
> > +             }
> > +     }
> > +     return ret;
> > +}
> 
> Hi, Jing. I don't see the point of the fallback logic. If we want to
> use the kprobe-multi, we enable CONFIG_FPROBE. Is there any reason
> that we can't enable CONFIG_FPROBE? As you said, for a "old kernel",
> I think we don't introduce new feature for an old kernel.
> 
> Besides, did you measure the performance of attaching bench?
> You will register a kretprobe for each of the target. AFAIK, the
> kprobe will use ftrace for optimization if we hook the entry of the
> target function. So I suspect it will be quite slow here.
> 
> Thanks!
> Menglong Dong

The Dynamic ftrace feature is not enabled in Android for security reasons,
forcing us to fall back on kretprobe.
https://source.android.com/docs/core/tests/debug/ftrace#dftrace

I will provide the benchmark test results as soon as possible.
