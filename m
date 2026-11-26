Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795668789;
	b=k+lePKU1Ujy4A8lkXwdVfhyECpAN5Tyuj7/nLbgYH4bWh1SWSBKxw1t5UNm8rR32890L
	 nM5aUwo59M2L4xfCLhcl28+XuVrHswT/zH5N6pqE9VcGkNbH41aMvk5iS8kgzXwoJpi5B
	 s8ooKmPV0Zlq6WbeF2aOPMHxcEq3rKCmk3aoxDJEvSOCJn/wE2clUYq5o6bSQvIDtsy2R
	 5lIay/NGQ7qILOo7rSUKbeDyNL5NmHn02nit+B+drhoG6gIW1YC4g/muXcic18DOAGCg6
	 X7HZtYhDflnL67e15ntsGQBlKQFXNKXKkrx2y8MHeGIxIs9DMP/d9rVscvezbEbN7fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
	b=XkyDS0oOfW25ujK++h3Ohl4nC0ZtfhmnY1+G+u4DuCt+gGukRqv2ntbX4rL63RoJGrNC
	 RRpgvfP8SSUh6gc4HlIF339C8BLmlh1li2dm/arB1V9S/Qh0co4Mg6qJVd+FI9CfsrER5
	 4zYir8eR2coevWT7R0WUoPh1T+BISQb/u3A+9wDv8CPDDhHQIIL0zWyisCWecFFx3OcCp
	 7GDvt6TJM7TsogqvROCyLf3Kn0gL2JSXHbl9t6DLwZr9vOt3bxGVUu6ZwVgB574VZ8gfe
	 g3YrXlUEHtW0c3GAaKzRALy9KZ1Q723oxhNRMZPPHQTAlX9ReK/9ZnUFFL7WZXggCYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Wt/H8uEX";
	arc=fail smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46844606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 04:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46844606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wt/H8uEX
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-54492d8a988so1599701cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 20:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795668788; cv=none;
        d=google.com; s=arc-20260327;
        b=D7uNK7FvSkN4HrHhnI8tIdzINExHc4jWXOPqSieUef7qseyH8j34I8USe/DJa9tcom
         t3ikGL3o9og9SPbGfZtip9b9oq0BSw5qiQXvB50H/WHFprINSMoUhCNo9avXcrpI0peS
         yTnXFmzPF2qtU5/x2l8KLPQB9ntNQVohjs8knCrk+uZx53VaSc8BgShmtfXofAdqsox7
         +v9wjZPCLskxIsF2BAtKBw7IK8OSs6PchG6lVGO4BCZ7GZBIxylztQ3PbszjPWHvBhgP
         m+579z3Und/ZlURpOKukkjaadSO66zSonDxofsOmbPH+YqnykU/YC1FZW5NjTRo8Tcmg
         7ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        fh=0+rBumkoDHFNwJaxZw8gM6OQ58UFGkXZM0uGDOxObSI=;
        b=kNYjzzJ7zd1TseBHKHlImJKnKX4hifFVHaaZb8NiEI3mGa4DHHErrLWPtksP246jt7
         FVV+f2AzSc6ZMbbBs2TRgKWrKATyjTND/0BmgDVEzMaahKjjCmy7Kkt3HZqJfROvKX/7
         zc0UVPfIxYi1cbxpjBs1Uj6E1HBdUg4anqkNczE4kGazNJdgAIcaxyk5xglEHUwFWW6n
         /Ftcd8mvIOU/IqILlV8EPH1KsTemWBPTDzOmD0QEG3g+85fcw15uRhW95Vs7rePDaZIw
         c9RzBzJUbS9z8izESN/jAPUxAzpALIsOLEeq+MFeQvpvs4tdMgx3zFr1tu7U5gy1skLa
         vvrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795668788; x=1796273588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=Wt/H8uEXeygfnRJXsnha4ogYR4WFdKKtucv0h74Hl9SvZ7ZVOZ8pyveIu/m+bbBuqU
         7pLEkyr5FS02oSIkkEdcPGP7aMYZHs2eR8ZbSslwbXiv4nig66Yw9zXIl5pT+EHlNoMU
         cQHBNyntCt6+GiY4hESZ00/HEKXKxMOneQnWVqwJdquEVsZ01fF3oKFb+IYLDHDd97P1
         5iwuBre8QUjJjwbIhiuIlmYLUamd902f2vsDR98ELoNLHrtAN91EmUr8k1YyhoPYh3J/
         v+aNlL3NNgtJeSDZE4JVJM46ZiSMrhfEMHEAp3euRyiB3I6N1f0aZKatBbawmZwgSrYV
         rmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668788; x=1796273588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=Z6FJcxxR23g3v1zGM+Mmlm5kwPsfC5wi36HjQ7WWVmZLhEPjFAEawf9NSDrSVUxW/N
         6SOXaeo2qI7ZZeMg0XJQXogvQ/0FvxzcdrdzNOIavKmznavy1RX87IJHEr63U/6lkDwN
         38gAySKHJsDdjZnyYXBd3rOUpHGkNhrw5uIACQ+9k/EIS8dyGgBlO/WXHWXBazC3be7M
         GHNBCDvQ1L3G/t/l/fauT70yETj00E9XAjvq42FN/fwrGAfY07lBgHDDctTOidGjRKmD
         oaWbFA7GjxIKgo4xzTKjYFTCgbnhy0sNSMthoY26AnDsJ5PBIrmMWM0fKUODhjH8oVWt
         wkOw==
X-Forwarded-Encrypted: i=1; AL+hErF+47IhVNsnrKFtsy/l3/CSjw9M0Od6qQvbJP6xLSraRqCsW+TN+tF0MgDNuQZxgeAzPmV0OLslelmmU+ii6Un6LBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AytZvIKDN4k1mgO2w7R3+hSHB0PqWCc2RRS6J4h68U7YIG5aj
	G/fFKtwq2661SFNiYP+VithoHGPAEdTp9oZVjaM0DRheJd7fctvYYgZb+8gstX8HT1PMJJ/CbJC
	a5k9UCRN2jaeDqQtptYOHQ5ooyn55bgUDFK+ZScAZ
X-Gm-Gg: AZFdTZdv3I1GND8Zf2jGsJady0hktAwP5ZrCHgZk1Va+RVtREslz5fzEo5jMytVQfJV
	J6ZYgLJX72diUj0FzgqkPF6wt0DBYXjhXqEdh01HLkxc0rBgJ30VM2ub31i2bkbAWN3hhobQfuL
	Z0Jbo+1Yf2usz79DNIpieDtiaIj1esQrD69BDtcT7VTGorQXJ8vrEHZBqObG4SDJCjttTBlUm2f
	6XsatHfeifwoCxHf2/d1Hba44hh7FozAxQdFc1LVIoVVS4MgCZDG2fEEc9bBilTsRQle5nQbw51
	pNXeZQoPEpz8k/rEcgrHntn2MJL+5ju/OtGlhGHeauwhv2iOsQuMx3qjErGkYjUxc/rD4LJ2vQp
	NRg8TQQ5PPY0UfPuLu7g4xuZlgxnSvX0C33a0+DfWSmX5N4lmYCTs3nWB4g==
X-Received: by 2002:a05:622a:1e86:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-55d88127bafmr101738501cf.4.1795668787640; Wed, 25 Nov 2026
 20:53:07 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com> <DN4FM3TBOJ9T.2QOOL77P5HETO@garyguo.net>
 <20261125132225.00254c37@gandalf.local.home>
In-Reply-To: <20261125132225.00254c37@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Nov 2026 20:52:56 -0800
X-Gm-Features: Aa3M54pMQmXw5Cgtc0EakW9NOiIZs8STgUuBigJfJMSZlzejGTE6XZMetCnzc-8
Message-ID: <CAP-5=fWkUW787c4dGx9rccucqD67dfRgwBB_SoCxFnfZXtXP-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/30] unwind: Minimal DWARF CFI unwinding for user
 and kernel space
To: Steven Rostedt <rostedt@goodmis.org>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 25 Nov 2026 16:28:02 +0000
> "Gary Guo" <gary@garyguo.net> wrote:
>
> > A quick question: how do you plan to get this working on 32-bit ARM whi=
ch has
> > its own EHABI?
>
> Do we care? Isn't ARM 32 mostly deprecated at this moment? Or at least no=
t
> adding new features.

There has been recent work on both MIPS and Alpha for perf events, so
supporting ARM32 EHABI doesn't seem unreasonable. Devices like the
Raspberry Pi Zero W/WH, which use a 32-bit CPU are end-of-life in 2030
(according to https://endoflife.date/raspberry-pi ). It is
out-of-scope here, but extending the kernel and verification
infrastructure shouldn't be hard.

Thanks,
Ian

> -- Steve
