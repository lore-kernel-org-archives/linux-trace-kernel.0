Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6128E0F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130534; cv=none; b=MbG6bNrbxKHtPwdxCA57AbaUdRYWXLdhbm46qvLllS4CUiE2V4zYUlwqT9gYrpKtURY9Wl4jsQvuv8Cr7JrFbpaA8XzxiTHKGOrWVOgpwfg5Hf48IxWubVsahLRGq/AagYmxyc6+PHsa2npNZzVLLQgzXBdFlDE1vAjwrPEhqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130534; c=relaxed/simple;
	bh=3keh0drJK4A5IspIKmRy+fJb/NxoXe2holMkNt2ddy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6aZ/i/cawSlcMKkcbWRYVlz5cUhlA9JAjttR12gJDZcRHgp/n3HskQLrlH8NQGM4+n0gSXVLvRr4qgFpXD2N18ZwPpkU86/LgUGJdWldtFOglLd4BAPq+IMTVXkFH7t7WzUqGUz+j+yjTIGCtE9MUmIEfRYRUcpiNQSh5Befak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4CF6VfZs; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4CF6VfZs"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so135655ab.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729130531; x=1729735331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3keh0drJK4A5IspIKmRy+fJb/NxoXe2holMkNt2ddy8=;
        b=4CF6VfZsmcVhs9FVWN7vQWsp0mAuwkJou1loNyaqadIKjIP9/MgIDTzEl48E24V1H2
         T0behTmA2D1etVjys8fra/K//eX3Fv8Ku+20xwgjKvWlUBY96m7rih/TCQ0ubwt85dbM
         z7i4Li6Z/u3Tz0uJewIkIpKQOrQDfRrC5xjn/e7ssVSLilBz6N2oDnvcJX4B1AH7WXR1
         k+QLkKnWHJAsBzp+ZKqwv6muKIqWyoKLMC50FaHZJHFrWVG1vsuYYg899HDCbgUcj/BP
         Yhro9Opl3N0u3Ap/lkz4robPdSblY/dYQCpuENpn5R672Gpl7QfJ06NXFj/tYnfViCiK
         oLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130531; x=1729735331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3keh0drJK4A5IspIKmRy+fJb/NxoXe2holMkNt2ddy8=;
        b=mzsRXATIp4ctxK3f83cHqUm4VR5aH/HsphTgRmlBT6jv/RvvbIhNHGxeRVPJmKoSis
         H0hny+CP4Br8EpnxMUNrCq+sgIyUv0+s7DtNYto8KKszISG198sodQNIFMDhY+BdoWng
         8T0tuBc1r6mjAYZ1pJg/d6v5JMtyruX50SmGwkcbRjQbELUxgr3vx3MH3vnAUMTstKrg
         6mXavHxhha0PbKBEP/Fd4ZUZtvRZsUR+TWw388sF6lU5mBZdyemOVJ8y2/WsZwoFrk6E
         u5P3ON4hl4nwYfoJ/k8yVK7gmwWs7ATTw0IZXY/58rQ5l+62xd3Hs6a3SyR37hVVZnte
         heWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2DosfPVUwlhMGE1xzoH5Q7Z1DCEmkKUnxg1wbds+1RUMqPB++CVeCPAEsUhlT67Lzw6jWgrWB/hS/r5Twu03jKgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1VvxHoRFRh7wG3YA9+LDitTWArsP4m31cVVbmffsA/+ze5kP
	Hp76BP2AdyiiLr7RNVFYKiagW+MnVcHZEyROxQXARRs61+eZDBV39+KZvzdsDzs17KMeqtEsIkE
	EQtf6bZL9tTJj8iIUjCktsZjWfz6Q/FzfP+LR
X-Google-Smtp-Source: AGHT+IH5iPpq9np2Qf/cswLWKMwDXvm2L6Ui8ogR+LLbQ2zhopltvCLAK8nRlN0DajbqNCn5EW+t6Jy5Dar3BZzKulY=
X-Received: by 2002:a05:6e02:1b06:b0:3a3:a053:c0ad with SMTP id
 e9e14a558f8ab-3a3ea04e3e7mr1425915ab.25.1729130530610; Wed, 16 Oct 2024
 19:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
In-Reply-To: <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Oct 2024 19:01:59 -0700
Message-ID: <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > To increase mm->mm_lock_seq robustness, switch it from int to long, so
> > that it's a 64-bit counter on 64-bit systems and we can stop worrying
> > about it wrapping around in just ~4 billion iterations. Same goes for
> > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.

vm_lock_seq does not need to be long but for consistency I guess that
makes sense. While at it, can you please change these seq counters to
be unsigned?
Also, did you check with pahole if the vm_area_struct layout change
pushes some members into a difference cacheline or creates new gaps?

> >
> > I didn't use __u64 outright to keep 32-bit architectures unaffected, bu=
t
> > if it seems important enough, I have nothing against using __u64.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
