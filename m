Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273034C9A6
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777837974; cv=pass; b=LqXmoncqO1saWEDlUjvJiJJkAOdx4jvtbIi3txvpXOiqroFoGeIL9LYkPGj8lt55HJPH7JrzzyWmZIh1FsHiYgRdmP+ZHVQLWTxbCDohswjzuIJBuUTHKawQEhTxBxb45g8EF/hbJ+et1xNNo8Swp7ZydMWQg5/CopN42Bf1CyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777837974; c=relaxed/simple;
	bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+QUYC1LolO8IirPJYAx3GYvAHnIKH1iriyfXGgoZwFEp/GevA8K8ja7gbmFZfym8zS0vecs6WHBqTFo0E1jyO8s/nwrNiWPZpSlEAY8YoyGaFWaEwNh8e0FPO5OD8e7IfH+e+U1JHjelYYBhNErgRDmOzrkNeuoVTwtZwWhCuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ4FVv4r; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ4FVv4r"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso39712275e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 12:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777837972; cv=none;
        d=google.com; s=arc-20240605;
        b=FPVAOacYRMA3kcslH+KtKvJW/npqu2doxCnfqlk7EsD4xc9CSkFrktxLf4SP+gErLh
         /l/DQ1u7tTAySC6DP0HdXvrx2594B7dD5prcZGU0KJ/ERKIjDND5/F8wVdC91LxdqLUu
         7FxZcsbV2DaZ8r/jK1HVWPZ1jTjo1RlvpvFbC2lF9Xe2JThdlDuaAoGuajogbzzd/mGi
         RgByc+fbedlfA9OX4J3AeKDyRDi9P9lm48KzJviJMcYJS/IyO/OuGjn8dOnuralQjB97
         tanmY2wlfFW2hnzpLclvXC9XHZXkvbrCU8s6jggRQavl7gSITNT+VFWc0pYcd1azzfmR
         dm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
        fh=/iOsEd2ZHAyI4J+hXmhOdwaNkqEh4fDt0EmFZmfPL2Q=;
        b=eJXpNpyCQTgLs8YVjKmnl6Phn7s90l1y5e2q52x587nrAQCugPWLvGroTh/cGD1lxQ
         cCDYfwLrQWzvyw1MzQbMwN5ABIVx3fKMaDtZ1SJKZ2HjeyQrkKH7F+tpfXRDzxKymAr4
         z1V7fy8B5DeROdJnphZNKTmJbZbzFifaYzgfvaguDuFSvEX01zt+45CLg7Rl7rd8ws3g
         7pEas8GMMyvZGmVn2HACLDH27e2Jjq5u32GL0oe4jjYX1i13f+SbIBf5Mdd3jsaENilf
         NSoW7f243X+yv0cPKENorNwXT05RnMfL96ARkcECkAo1s0d8B89T0F6Q/Fyx7cjBQea1
         4XLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777837972; x=1778442772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
        b=ZQ4FVv4r5Mg1K5HQGd7RxnNVRxvDPKvL1SH/j4p2CUeF0l0t63UNAoFSoZjYwmYQIc
         SsAecYuHrtclEG51/DJ3HVgLTis3XiOtblGc1onltM/ebSTNGBjhDJuKBi/+GoLhzOBU
         jm3nI+O9qAL4zXkyfGCKwyck4Slbe0RzHXDzEv0W7UVkTusS9CTetjLjsZ8ayOyitx4e
         ujRxG1jftQhOohBTvGKFTCfxO6BBgfQDCvBLnA0XuZgeJOxm1Z4f8KRQwUSiZrjDoRI9
         XdO4hqGZWgpOL7vb7GApb3XyrQ8C+Yom42isrdOZF52RKEgCvOPBssvPeAMpmq0y8/0U
         RAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777837972; x=1778442772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZLiEb2AKafZjis01rYd0ydpsrn/wl2hltrcdbVAOV0=;
        b=CzFunYprrQOOmtCuJD2LVfGkS0xIWimPTQjXipYOXjpCrdpWG7OVewviArqapaWWX1
         KCuZVnlXz/JHSPlwhOvqPvUCNV4p8kyVnt3x3tvDySng96hvWqIcEU5qM/IPTUrcm5AZ
         ejUkHTITv0Rln8PqUjoetqXrg+eYelc0xVsSoKu6iPk0hvgRbaCVuzSTNbgxsalOx1fY
         SV2ZVu+I24GX/yPGAqbQeKTNTIz4WZTRvOc+2Jfc/z+3Sd9JYahKPE7M8juFKtlDeHv/
         QGZ9Vq7rJBb2owyzBIYn2XkWw4f4z1HOGjgS4zyuw/NViuwmLlu/l3kOpbTzjtrPHIP7
         aPHg==
X-Forwarded-Encrypted: i=1; AFNElJ/jX9CPfHuZUFDH5vBAMJ6Q1aj9L1tgJxfE3HuMCLXX3yYpgvQV1VBZYPhaXongKWu44RoIjbX/UwJ29c4LPtqW+N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp52yInQetWwgtyJaTS0u7KaWP/aD8hD4ZBilHDuGtIIK3EoZ2
	5IchSJfkDXgVnTQ8T0tWgJC+GHxOY7ZrdOMaiCXi86A1Zi52h81v0/MrlsBOtOsONEleWUcseXe
	MCXucfwU9ke7DarcLHJqbu0B/ODA3AlE=
X-Gm-Gg: AeBDieuVGjf9/7G1QhXx0WUl3qo9SB5yeLPac5/wzuA2AR9MFR41xGvgL0wiThP8O0t
	50SAsEWY/15YLYUt7MLGPYpqY/MZdjZPn81DuAehUd+ZW1mNoDn43HBR8vrsO04kzS4fU/VFc6/
	dsnSU+dD7q+egKFgEcYsPNDGs4wc1+LxjS1u6HQ9v3E97T6hASwQCOWiyFGd8pXWujBtwAjSP1m
	OlM/SZuN7MOP657iuW5ptFhlSe84kyBD5GUuouv9Rhxusw3a9ILFaTs35Hol0D8AjQmJ/fWmB6d
	dupCKSVm7LjPVBdC/bwasRhwuYI1Ft/TXWIXNvZ67cyk1Ejw0kGWLHvIgYoF07iRMcM6LEfZYTs
	+R88=
X-Received: by 2002:a05:600c:c170:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48a970ab55bmr105961725e9.5.1777837970601; Sun, 03 May 2026
 12:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503190119.559696-1-atomlin@atomlin.com>
In-Reply-To: <20260503190119.559696-1-atomlin@atomlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 May 2026 21:52:39 +0200
X-Gm-Features: AVHnY4Je_hdJXpt18lPdcni3VJdqTxwGXnWD7E7YxoG0u0WmQy4IipQtUwj54IE
Message-ID: <CAADnVQKf8=Z31fqYSVRqpGa5a0Q_-8nS5uHLfBNCYUeJrvigwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 9:01=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>

Nack.
See reply in v3.
