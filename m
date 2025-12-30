Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F230C637
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767090320; cv=none; b=Ld/9paWdWJoHLtQwNhbujyRb8KHElrZhHV9mLKBgE5vYrBUolA2x3pi9fBvit9Pi7aCI7WfSVLbFZIo7WzJzQt60zRSgNbbktop9Y4TvlfGEDulWaYMfywHiEbYkkVvsH9vmGxUNy7iIsReOPH2HLLdv4T9SYtUo2iGMpwl8mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767090320; c=relaxed/simple;
	bh=/VSZ74K1uY6N3H8Mr1Ai64tMiaecLyjRsEQB/U3nhjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKNKmDKeaw1MeKCbXcZO+sglOLxnau1mGyCuEoIl8WVcaCaimHcquwlAjKuVTIhWuFphktWocSRNZSbG+tv0DcA96Gpnt2dfGsuF3z6jijcnWWSBel+HovU+OoNI6p4dyPXmlxszmMOcZxWErD3Bv6yODJMsDT2zdwD3ECnMIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+qxgqtJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+qxgqtJ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so9912023e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767090316; x=1767695116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RPcpI7K50l83ubXdwZ/J4R5m6Hdm2AUvvLHKciAkWM=;
        b=P+qxgqtJTwPPoJQlMvnoTsB4PV/RDrHCyxsgnNl/2NtwKKxV33ehlydnDkRm8u7/Pu
         /gQDYfZrSVCoE6cJ+To2WhsnoMjYzhR+mwBeM/cLXlpMFxGhgu+RuDmsRz9n6Xxl/WH5
         74oQxXTdY0JlN+j6c3S4y+7atIEpn0SUaihIOqpGsi+/wb6oQFWx/snhQIeHD7RcP1sQ
         gCyHvhk7GULeANcE95a6zUV8n1+cETmwjJrELICnssOAhuKHtbWnAp8Aw8kocJPFEesy
         Y9OR75IWKuSPIhOesipLg1iDtzk4Hhblk8SGKnYYabeyz1CpdGTDtR/SOQ/nCoy9ddzl
         ah1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767090316; x=1767695116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RPcpI7K50l83ubXdwZ/J4R5m6Hdm2AUvvLHKciAkWM=;
        b=WWnFPiZ5Jg5GT/CLzF45ET+U1EBv1xsxDlSLq7KwHLLA0taGTf83r4IAiN86YlDCIK
         Nv7vaEVYLylYLOBgUfjZVAiWt04Hyv2Jao3Bn2w48mclGqOzU9gBymH1h58D34P4b3SF
         xxxzAG/nc733Ry/WpvYkMxJBmnf8m/p4qCHTmZ/GCk4K/VN8GFL5ulusMAiRdsHE1dqC
         96JClFolK64CjR7fkqbJAzYef7o0rCHKZb6NhDUMBU+TqEEVkd4TLZ7Ui+SNrNODXnmU
         5CVLd2v8WtKDjREG7rsb31juMr5BLPViYxMURAPPT9VAIkG+L2d29BtWu72FmeI4AIW1
         BdCA==
X-Forwarded-Encrypted: i=1; AJvYcCU05VBXSIW8hyzA4/LEtMjt5GogpktyL1YeGW80nFNMNUBxvNUIVUBTZgiHnHNpECI6P/hXTE/TP9ygbXrb0zds+UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywes9b9v8a/gLFVlqLzND2jtW1kkV3pJMZ10uKGFzkic9+PeJ7x
	J03x3w24KycVXhjIHiIgz2yVNVATVIMxDbNU9Az8+HMNxassc9OLoL7A0TM/xsZGn2/N85sY3XZ
	JBjzyDU4kS0Alnin9qSzXHnz7VghF7RDz18MP1eLGDLgir4z9RjcB
X-Gm-Gg: AY/fxX4isZRxIRqw1yPxYdYleSZLtJMVVbKsD2Iq/Rj/TzSPz+mu7lnbQAzHG5J5mYO
	CX/fqmMWVAGg/CX2zeVAbR8EzgRri8bnsWbbJfTl12iggPxKYtqsupLU+F5+I1s78hLb44D8xzr
	gOoFT6miHfYxzN4ri9Ngfx/L9R68S7yFy70DqolB8jKq0doA4wqgTdNw2RNI6Ae0eyNWOQOOoRK
	057KTtsIexqBqZfKpThIPsPg+KsSvCohqLfLys4s6pEfZsCSWzuXDs6bB3K1dii/4y3NLeyVFeU
	5kzQ8lFsLrScpaNfbU6WDSc1a13UKA1gpecbSto=
X-Google-Smtp-Source: AGHT+IEo1qjkM3PScRLC0zuD2fxyMcAVISWCGFShEn38v516f4OpRquanW78vE6IBUC6UUz7Q9sRBPe3RD4V/4nGbMw=
X-Received: by 2002:a05:6512:690:b0:598:f35d:952e with SMTP id
 2adb3069b0e04-59a126f3099mr11326772e87.25.1767090316398; Tue, 30 Dec 2025
 02:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224162000.141731-1-marco.crivellari@suse.com> <20251224133210.7b62ba5e@gandalf.local.home>
In-Reply-To: <20251224133210.7b62ba5e@gandalf.local.home>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 30 Dec 2025 11:25:04 +0100
X-Gm-Features: AQt7F2qhbBfpSj4_FUub-eI2bIe6gTko-wt-MfAQm_37EGlWCzJfBl5NJMBRCM4
Message-ID: <CAAofZF4h65MTAgEuK5+EfE5SocFE3FfGWAcrLv=6fvZrgFtAWQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Replace use of system_wq with system_percpu_wq
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Wed, Dec 24, 2025 at 9:43=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> [...]
> > @@ -1375,7 +1375,7 @@ static void free_filter_list_tasks(struct rcu_hea=
d *rhp)
> >       struct filter_head *filter_list =3D container_of(rhp, struct filt=
er_head, rcu);
> >
> >       INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
> > -     queue_rcu_work(system_wq, &filter_list->rwork);
> > +     queue_rcu_work(system_percpu_wq, &filter_list->rwork);
>
> This is just garbage collection and has no need to be done on the CPU it
> was queued on. I guess this can use system_dfl_wq?

I will check and I will send a new version with the unbound wq.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer
