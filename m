Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBE3590A4
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467105; cv=pass; b=RMmNOZseFlKipVtLT+/IXRxQJR/wix9xCvzyyIVgAG5hagqNcYh/QniM/ekOL5KePAsEe9avPxSkzXFnZP+e6QMhPUrcyogKhgA3SsO2A6ub3iS8Qzq3mBVYTCVfcC8SsFipE7Mz5lAYcF8L8VHhqmR2M0U8muxvtJGwAZpBMPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467105; c=relaxed/simple;
	bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8uKcOUxAoUmoOMxHRzS0kkMxPLohNfToPlrv6+6kJTmnbDa7Ps9940p5YnTN3sbR8Ssqn84WGAvCfoVr03fE2dHgbEg3AM6pcSQQlIahAP/QwAdL1wUQ0FJ/HQedRo2cVVVaHc/Glg1xqZIlMDTJf+HLVcum/ShSkgasmWzc34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfuPH7t0; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfuPH7t0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439baf33150so668159f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 07:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772467102; cv=none;
        d=google.com; s=arc-20240605;
        b=Z16XvvK3IPCu8ULfN68uMp8wdNFqzt3rLPeFCnX+ggVbI5liDcrlBvGC9TdSzGDWY2
         NLtNDJTh3i2Dt4fa/Q2QbE4Z3mjUjccwBYWwItKQvX7lfPSkrs+dA+0YIzEa3YGfTNs5
         ULRPjdKruRfjsDhwqBMcvwVmlNUnMdUdq1DwwaZjf80j4Aa8NvMNQgStM8g2i3XKoOj3
         vtBHF59UvFc1TASKor3sAFsBYdTZeJzOulTc7UfuQRpLxZSudBy+lxpLZeWE0toRT8V5
         ilrcr/hMMxxV9pu8DKxCCptVq0pzUItTCGqfHWnMThzRKXvXcuakDIVMgZ0mwHVzQmjF
         X/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
        fh=4RZaT0rnIRGpzIWJ0wMmODpv7ZD17zyp6VsaoCAAN6Y=;
        b=Z2T4FADYnIil11uy0L2jvshWzuBhqA07sXWb0+5wWwhwZXGmtXJcOPyiWYycJzwt2b
         98bmeyLuVu9FbIZ2Fopas03CrDFdTrCrH+VFumDdxVQFGhAP3Zo5JZHmBRlpp9fUMlbx
         u6M2BpuYEDMAVmEv6TeIuLb5c1Ct+2sriKTFk+MWW8R7jkg2BS220mM915czCdhtkK9p
         Slo8Cu5O1CoSnHsDmkLFfove3ZfOJpIJquY49bpMJFC0c301UC5DKkzf7wKIuPfdaLpm
         cz5DCDfrCQ3N8VTnNsZrIDeY5DMxUMj2szFkrLvVAcpguGh3NNw9dctngc14AmIOy1cG
         y/hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467102; x=1773071902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
        b=UfuPH7t0fBUoJU5kJwx/P8nMCN+9gGWkIdbsQDuXFVdN1K3pG88zzwz+9mtk69kUVn
         3WcRJ2z6Dhlep+CH6JpCjGwGD5yW0HgfsSsLU3JktluhEo+XE8J8Ckm//B6iTdo465yr
         u6J3l/HvP5ieEuovV3TNwb6893zFm1lXzL9GA+wLmlbToJs2wwm1SIGP+1hc8sH9F0Uw
         aChdtDvhWCODglEd9nYI+EKaHkQU2foq60mW+ru2o9JHKkpskrwh1/+5wC2tPnXWADIo
         e8xNComQwhKlX1WwD4Yz7KzkGMOfWY3lugL8YjU1bRsFBH13WlY3Uqq9NLoS+kFSnalb
         RpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467102; x=1773071902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TPjtAXjXkz2ScoCpqpIUeYNfC8HDnwi7bbiTfsh7Uc=;
        b=fZjo/wK1hLrnjJd1AOuE2vYeEKxTS5Q0cy1x5d9H36ZzNQoDeCKInasuCuCiXl/q94
         DV/TFicenDl8jxlO0ETEkBB3JyboTidVIVdyprgmgmCTGeaxVUB9RqahuhMwtsM6Bn2U
         r9AXyLRppnkltVkWJ2H82M5fhiFGvXvzPR6UUuYTlYq0lJ7/GBQz+JvIifcWrXt7OGcP
         /B/PrWl7Df4dgQKQuejO3kSKYxjSe36g2Y3CBAiZ996XcyZoGJQI9WUyUu1I0isW7zhp
         Y/gpeiG9CZLN3hXBNQdvy0PSTY6ECgQcW4rqo01HKYDqCP6KdUfPf/B1aMn/EDTXxnQx
         l1lw==
X-Forwarded-Encrypted: i=1; AJvYcCXlkrmTj8tIwHiRoKVxAxHmL6nRrjRa9Fq6+pZR07NhAdmRws1Ftij4BhPPZAjDQrukR88GuOoCqer+WBR/sRyU8kA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu93WfOSF2vDfaAbxN+nyTpd1wglUmRZfETUR621qW2XMBBbKm
	qzIT7EbkbOp+DVXiRhJCyMhYX931rObg9LfOcWvbZRJe4oEf/Wi2t1UbYPFVrAqDII6PE/7CYhl
	qPbeXE8wyvbj8c6Nli92ZqetuznDQtnI=
X-Gm-Gg: ATEYQzxxCE8+WrwRe/UYOdn3G42HRr//aHUmxB0UWYGpDKYpqPuTdeSx2oP+RCNqk6y
	MEIT794ocOneqPN/LM5/DWeiPVVAqmTA0NVaeKNkWHB4k87lZ3qDpXsDqVpBEA5AXdG2ZFdc5Aq
	sI+fOF8VldqxvrcH+mL88taTZVTpiZ69zOQkJsrYTDjlkYh1GFXwUWBOWgtVT8yLChl0/919myl
	a/2aRxbtlChoq7QnUniAj4Ccy03ObVR7NbNnFrX1hcedoYfqurIv5gzsvWf4rK56gvVx9ZoIm+m
	HTm1TZZ9TPiMiCWBr/T0oiBX2OHY/NOCqA9uUP2tkkcROFk10BAEFHvrFjWovUUWgnIonOPHHvQ
	mhnVlMw==
X-Received: by 2002:a05:6000:2411:b0:436:3761:583b with SMTP id
 ffacd0b85a97d-43997204715mr29586238f8f.27.1772467102344; Mon, 02 Mar 2026
 07:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302081622.165713-1-jolsa@kernel.org>
In-Reply-To: <20260302081622.165713-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Mar 2026 07:58:11 -0800
X-Gm-Features: AaiRm52_d2IDD4Or5e6YvBC9gr4AV-b3oFE-DpqVFN7rfeGBIt28no9bc-gd-cs
Message-ID: <CAADnVQKBx71HOwVcRFj7ja+y_NL83rpKQ0BRcismOwdCNx6pbA@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 12:16=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Ihor and Kumar reported splat from ftrace_get_addr_curr [1], which happen=
ed
> because of the missing ftrace_lock in update_ftrace_direct_add/del functi=
ons
> allowing concurrent access to ftrace internals.
>
> The ftrace_update_ops function must be guarded by ftrace_lock, adding tha=
t.
>
> Fixes: 05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
> Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Closes: https://lore.kernel.org/bpf/1b58ffb2-92ae-433a-ba46-95294d6edea2@=
linux.dev/
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

lgtm.

Steven,
should it land through ftrace tree?
