Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059F3382E9
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281719; cv=none; b=J4q0K1tPJhVE4a2ef+3M0vrW2vyi+uV/2hhSwnyUy7luaR8SVr9wdiipSdtb99eJvuXhYVuaHElzD58oxQhy/+H5zcSz/GknSlLERxX2MhgfZHCzX3Aha04u3hcilFBT0WUzo+ZmIeoM1Sh/Ku6+wUWgDs19NOKAG8ri/27JLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281719; c=relaxed/simple;
	bh=TO8T8T3MBEVRJNLT1pnFgzJROWTawlpJKSr43b0hRug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0w8sBElm5EpssjGBbitpSVoLu74Kz/sztrkVNVtk+PWCWoZlRu1WRG37yUM/bkXv+zwR/w6+2h2vgQpPbdDAOOv5Wowm0u1IhUDjnVD6X5spdMyQlE4P8H7xyUOkR68XGhvF2QHMaIBxfXUGbWPaXzRt3uuDvd+ny5aIN0Tdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGvsTrmG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGvsTrmG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso6771355e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 00:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770281717; x=1770886517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPbYr9plY5gI40v9Y8GEacPTdPqDKVbthrrgz6453C0=;
        b=gGvsTrmGtDY9UO5BX4AjwTmge1dsJ45xX6R9H9HWZiuYXG1pXT2bnTXcea8a59eEzE
         c/1Vjc1tUti3oyAUiRL7LybbgmCrpWWcZt7lX7lep6ODHAu393ViRcM+wesDvMPopx42
         dxchQLRpM6GSh1Zynn7RC5FS4dmzue2g05itLhZ90FkpVOVfmTexSVniCWa2bL3AMNzu
         CKx8jOYXcBUe9LnJOlj4cC73vdFzuJ42nZsdzkzqbP8iCNHBTj2GhGyJogdnZ5BzMKTG
         YmmqFOGUnjkkUXoNTIx5K5YeXxQAhh8viMdj5lCW627rh2u31Lm4Ql0FCEAM0i4MV0Vp
         B1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281717; x=1770886517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPbYr9plY5gI40v9Y8GEacPTdPqDKVbthrrgz6453C0=;
        b=VDPF/eXlywcrgr2Ls/acr5qj3cRZy0CP9xXLqbQuKDQIZYjSd3MmGn9fA+PsoOJfLR
         ajiKHF4WJ9tvQq+KWh15/xLTipvVSRZGdgEyJm7rk1aMXxeFdYBCFM0MQk9TS4OBREiz
         kQSZ0u/gyhqb04B/I+qXXJ9fFpeR7/ppwPfgjOdOVgdp85RTatCT4RSeveCmBcfN0zJn
         jU77QVZNym+yng4VOnG9/8MG0+oK0d81N8M/S+a6nB3gvUYmRP3K8JHbVjYsVcBGeyT5
         Fb/SzAPzcpAJFrvt7H3HVDmg+x3qHVCoG7r3SSrQumbz8nlY1MnC0JQn3J8p2kYcM1P2
         pbGg==
X-Forwarded-Encrypted: i=1; AJvYcCUIjD4nwhznH6S2Q8xZnSgs/gc4ZUdPceg5A86PLdVwWnyWTdPVzNZPl6RLR1RKLLDeqNC9MBsfeQDl43e6ezyUlm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB713uhwdUSAeBAf79U4qdKJIY1HJdwvv4yhJ9i8eJlfye5S//
	nD6hfeMq2heTIcf6hoYCO3HKITg2q3AI67LKHbmANCmruoPdigmI8eGi
X-Gm-Gg: AZuq6aIvhiOzbUL24k+U0Y1t5M+KvMp7aya1e1yowksVQ8re4qZvprtG/evPwDHWFiL
	heGUuf9E/yki2GAtkVT02p50ICn4sKyAENST9V9xsu0ZJHMKPolkS0COp/nBUqfwIMMBYrBMJzO
	cjySMrdR6yS/y9nzkPRZrH9T9O8sAg7mU2PmWnWyYa5AN90iKMUyeTR2u7jO1kxqd+2FS2IO4HQ
	l4Bt+GPmHcu3OVEroqafeTW5v7w1rX+PPEwVtgU3clF8Zl1re+vZIyL9MZaUdgptw9KfZoV87ew
	0zLNlaqmdxATH3gZ4jCDwCtVA3+RuE+rDiNfFTJWgmSklbnqfbYODV7btQ6FzGSkyNz1PAhcdUv
	2UtSGGL05k7Uf4Xl1ZXfeKVBVVi84IhQIFs33afZPFf4b7KJGmuksk4O89Qyz
X-Received: by 2002:a05:600c:3e11:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-4830e93ee70mr79551375e9.15.1770281716961;
        Thu, 05 Feb 2026 00:55:16 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d0dsm12749935f8f.7.2026.02.05.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:55:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Feb 2026 09:55:14 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 07/12] bpf: Add support to create tracing multi
 link
Message-ID: <aYRa8icSHFrfCyJ8@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-8-jolsa@kernel.org>
 <CAEf4BzYsE3W8QvtKBOZZWGudFjXJ-_szUZOejT-Ab5v72Sei+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYsE3W8QvtKBOZZWGudFjXJ-_szUZOejT-Ab5v72Sei+A@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:05:09AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new link to allow to attach program to multiple function
> > BTF IDs. The link is represented by struct bpf_tracing_multi_link.
> >
> > To configure the link, new fields are added to bpf_attr::link_create
> > to pass array of BTF IDs;
> >
> >   struct {
> >       __aligned_u64   btf_ids;        /* addresses to attach */
> >       __u32           btf_ids_cnt;    /* addresses count */
> 
> cookies suspiciously missing?

right, need to be added, no mystery there ;-)

we will just assign it to the bpf_tramp_node object for each trampoline/id

thanks,
jirka


> 
> >   } tracing_multi;
> >
> > Each BTF ID represents function (BTF_KIND_FUNC) that the link will
> > attach bpf program to.
> >
> > We use previously added bpf_trampoline_multi_attach/detach functions
> > to attach/detach the link.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h   |   6 ++
> >  include/uapi/linux/bpf.h       |   5 ++
> >  kernel/bpf/syscall.c           |   2 +
> >  kernel/trace/bpf_trace.c       | 105 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |   5 ++
> >  5 files changed, 123 insertions(+)
> >
> 
> [...]
