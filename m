Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394154;
	b=vaHSQC8u4C5ExqzeAGXCQyJi1E4UvyRu3CVLSEEqVoMwM3KgwUZTA9vUFtYUQbgVz1H1
	 NkjX2o/89iCiup0Or6OEqmMHjXsTA1SqbR4w1mz4R566/FN02hCIH0CcUZxdYUn9/3Oxr
	 TZNAgkePhfJT847VwSorK0WbYpT/ae0G0FPNF7Dbh6mGS1Z/hxxw53h7Fn3RGY+Ou2+VZ
	 coVc9olMbJCj5nEZ//21d0gu0sGuKDK3zgqU5tYZbcDkvdEoNvzNFULCwTU2tm+6KIRPa
	 PUwWwvDUsH8w5zUZkYG33tnpm13aXYadKgkAnMB84iIhT27csgJ8SHzfjz6SL+Fc/rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=fkkdgBcWl/gXMWZL41R2xtfz4IY0JzduuuEbE0bKcow=;
	b=b0lv/thA2xUFPos+PGvn9Oj9+gffCI4FkyOBEDg12De0+5NcRC/UFO7Efmy+ljfIaYkp
	 gIA4r3B0inQuq+xJjOCgLZOj8hEJFAC5ThJUio2LnCcGq4ym54WkhFP/atsf/xJ2cH8ij
	 HAN+bhPJoRWk++ja1R73P0cfQ3sEqDg0/kFIIk/IARJ8IJiQDOq70zml2IUxzxLGAiOmz
	 1zBfPT2fQTZpNaAL+b4Ug0bdR1xWhsVV3Ey5mlKzVJwHWYoA1J+6XkRMqLHD+S/UuYJdz
	 s3b0nDxAnGLhfj24wv71PdjmxVUaAq3yG85/bFOSxdTk68J0LEVmCDyPIhEgx8YTffQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oooZo4JY;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69193606A89A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 10:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69193606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oooZo4JY
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491971ac844so2860323f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794394153; x=1794998953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkkdgBcWl/gXMWZL41R2xtfz4IY0JzduuuEbE0bKcow=;
        b=oooZo4JYlJ2CA1rNGsEhbm/Vh1zARDhdjXBHBkBQFL9enJyj+XofgSJLMeZ9+GKxbo
         xok/3WGW+7zKaDcdDmW6AmGqsymXOQ6yiG/TEMbbbrEyTpuEH96hQdA2JsfLDtw41Eyr
         Sq2XWmm/XXn4bmWMceYyGu6JBYckHG8RS4VEVfx00q48LCt7osTBKv7fub58aMqyjRoZ
         nslXmn7Y+YxO6NwpCpCXO3PtFaKh9qhBufe4ceuiQ2H30+4TNUaM/4xKC0tBs6QDF1P7
         vrmAAtrDs3bzYwahjECqPBoax5ttmw1jsuUmag3V4MtFo5Y25+V2ukVgT+hGMBD5uaJB
         CsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394153; x=1794998953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fkkdgBcWl/gXMWZL41R2xtfz4IY0JzduuuEbE0bKcow=;
        b=KhtTNJCJF0XgETjbStCoLQiiw1BPbbLJbDQrLGEAcjao30sQ/EA68CnvCOqYogp4Ix
         TNMUXNLQVCdhaEK+hdYH1GU7Htqov5CsjT3GvRPPVOGn4RpVrOdIZpLFH4WLienCLupt
         fEf4hOk/icpAvYf/9okCx5po3LA6m7UJOyip+ORvWS970mfA360V/tQzoY7voEYxC28G
         X3tkAEoYqgpcF4kqwdWTA965m/2+itY1RLd38elGntRAVT2Afy8nXJziYAdvKdCm4+9W
         XaioLBDnU81G9HITHMw3svvXTEOyAi4ENNIJq1SiO4Ci05Lq7fUK/7sWOaojmEqXfMPO
         TPLA==
X-Forwarded-Encrypted: i=1; AL+hErFp97YCNQRqH2QxlCiNa9R02+ROtIvDrfecodpbpo2sI1KP19CrRAD4mtnCAZk5y7bxnCAaELw/wrFOvKX8X4EtIWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Su3quoufTU6E14O5PKCcsIeJCJluTzxwWIHVzlbvLJNqhn9cJ
	dhrVYMhmyHRbuXi9OeoOFDw0/mCW1IQJkSBefBESVtlCnnsBlTBxPTTC
X-Gm-Gg: AYBFou38m3lFX2OcHyxJUtimlAauv4vmQhgqDdBgK2C3FIk7zwXdDO6CP/IMGVEhBtL
	3dhXHGh3ydefBFfWZRBH+vFoNkfYVUxo5LuoTAasVXEaqy0vCGryrcseVx7PIfAjBwxDQBg5cMo
	BC8F67Ge66Uk2UNq0Bn5H2/nFVj4tnb+wsWKHEYcBvwc+HK4K1OV6NqZR+SjyqPSxUbuMTCU2ec
	E8pkHm1WztLSkzj33A3P44gtEVfumKBTrtV2gU6A9bVXktbdQAsMTfLuMi3kV4TrlEv+e9L4/hy
	yVmZWfPYNkbIajEA629hjuYYiEAYa4uZMTAk6NMnHFhTUCd+ZnHiGVwnKvH9h7rCOTl7tn4kmL4
	u4cQiVpf/JIusR+8QnLWCICN963DfIi0w0BLIQL2mVcuJ4erbadqp27AEdUZMJtimPgPvlwry8m
	sSDr/+2I4FiuU0+CKUW2YqkBjfeMnDSqo9Tw/dQqtl1GvPyYRidJvT0qd+XP/dYQYVY3kAUaF27
	vRw1t4AlSfkXkXvITmZj15hWDHXwyoa/lACHzKdYd2g+F56Nk4nQNcDHgZf79AwW9fm2uAY84TP
	xDA=
X-Received: by 2002:a05:600c:19d0:b0:4ac:aae6:6401 with SMTP id 5b1f17b1804b1-4ba09375031mr37014455e9.12.1794394152548;
        Wed, 11 Nov 2026 02:49:12 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c05dsm10153242f8f.25.2026.11.11.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:49:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Nov 2026 11:49:10 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Message-ID: <avRIJuSolFTwT_Tk@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109195517.1090787-1-jolsa@kernel.org>
 <undine-1794298339502831052-1b6960b8f9b38e7d@undined.local>
 <avLz8k0gdZwYTeA5@krava>
 <undine-1794325083765212173-9c2dd2a4d5c010fe@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <undine-1794325083765212173-9c2dd2a4d5c010fe@undined.local>

On Wed, Nov 11, 2026 at 12:38:03AM +0900, Masami Hiramatsu (Google) wrote:
> On Tue, 10 Nov 2026 11:37:38 +0100, Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Tue, Nov 10, 2026 at 08:12:19AM +0000, Masami Hiramatsu (Google) wrote:
> > > On Mon,  9 Nov 2026 20:55:17 +0100, Jiri Olsa <jolsa@kernel.org> wrote:
> > > > Add an address-ordered rbtree for registered probes. Keep it synchronized
> > > > with the hash table when probes are added, removed, or replaced by
> > > > aggregator probes.
> > > 
> > > Could you tell me why don't you use hlist (get_kprobe) instead?
> > > I would NOT like 2 different lists which is basically doing the
> > > same thing.
> > 
> > The speedup comes from finding the first relevant kprobe, then iterating
> > over the remaining probes in address order. The hash table supports
> > exact-address lookups, but it doesn’t provide that ordering.
> > 
> > I agree that maintaining both indexes is less convenient. What do you think
> > about centralizing their updates as in the change below? untested
> 
> If you can replace the hash table with other faster design, it is OK to me.
> But I would like to avoid this simple-adding another lookup table for the
> rare usage case (because of the maintenance cost, and duplicating a list
> makes it difficult to handle cases where discrepancies arise between the
> two lists.)
> 
> Can you change the size of the hashtable and measure how the performance
> is changed? I need more options.

yep, I'll check on that

jirka
