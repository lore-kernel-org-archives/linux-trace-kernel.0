Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466188;
	b=txSFavHf37nuEX114XeF9ZiekdkTDEdqtJn40ijz7GxskyBzebfNIjwVALJMYKApGd+w
	 xg+6V9TyQgGjdYZfmVBvjNvjD4+6VMWZzNryNHot4N7rORGt98DNtsY41DzPAGIJeRh7H
	 Pi10SYjAAT1XizvDJ0fKG9Pw06N2ps/wnwnGURV+F76gkeqD+DZs1Qy2oNm2tCoHwWV2/
	 XyL71vTiR6g7me0kZjbWJzw+uAnJ2ndtj/TY0is5ZVDwoHYYiL/cNQCudLSJ0ePo0dwXT
	 M16as2FKr51CDhnuMjsnsJBS3U+yMBj6CU+4PG1pJQBY1JxJivpxI2W2IBEf8zB6Q0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
	b=jw5OhF12SeTlJbUhRyBsymoW+21Ev6hcfiUDaLb4hgfmdVVsF9lPgWkVXRRYWS/TjBXx
	 /csyyrlQ1BjocL5pEBJG4YUX9BT9OSVb9zHT+BcIOdUP0+xgDk/4L5FcV31ZEe0XMNdl6
	 9PMjuUtM+H5a0x1bLbwG4mOWsIi5SC3wFYDQae2uZtH9t5De6W5GzpyzAE9SL9STCyBZS
	 VFYvF+dkaLihUlmvux0ZKv3QgFnxjc6tVbPZ4cAa4Wo972kgABDAOTMkr7WEcsdxui5Fb
	 viUsW25v3x8fttJCH9kN8eDJ9mzVkUR65wR01lPVnnQ61tofUjGJIQb6Sqq40qO+c+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8E3v5cp;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C19606A31C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 17:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8E3v5cp
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070755c8cso777955b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466187; x=1794070987; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
        b=i8E3v5cpMSfAi1mqqro21Q/8Raqh769HEWZJL46CwnM2v9wK2OLVzJsAuCSE9qf3zq
         tQY50fNwQDpf+SJSRQlAgqkCXH0WUUKhP57b7/iP77Uf3WNogA/laZGasAKdFWEz783R
         toarBNdQRNtB75h9qwyX3N4XLDJa/7DPVsqKt+7a6In8nxnIlpSFdU2WiAXEmjKaF5ks
         XnZGp+AauqkTqlVVZmUVXtl4Ag0HgI6GlxH75NYUPYnvp305gsOHdLStmb2NDkg/ihGG
         sRkldpqZ/xsViTVAvbYKqxtnovFp7bSCwKkO/qhbTEhCAOOAoI1dYAM/lSLdEuekL6SG
         SZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466187; x=1794070987;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
        b=bwEPPDyhfTOvEULeGJXdB5vEHZ4ZrvxnXRHJTVCAcS3iMVjcS5wUKar+3tanB0bTa9
         JqtfiagPmTL7NoI0sUjL2QHTAXlCKPmIj/GlVdXXa0LTuDCs+rMYpdBEJOOiw/ExskbQ
         EBgBejfQbMtnUoQBmSv8U/OOBGCuSHl0fLf6c7KwUO9+D5NA9MEuakQHzJFLfQEhiUc4
         a+t+WyY10vsSXZ06unYBcSpkToZJ6eorXDwPuBZPBWvebOVa1MGG207ZuHvdkhFs+939
         Ou92Pmg8qQyaeGTNof6hyV1bKUxtiJrkQ8zUGPoq5PWDPTN/0WSc25ldnBtAIik1SCsC
         SYag==
X-Forwarded-Encrypted: i=1; AKwUvBy7vRly8HeFJxGBxjYB1nxIWXyr88O5fq8moB7OtXS9jiDwsNVxBbUF1j/yquqBTMzLh+VG7wPTKMN7muDihJTuKqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcsw7C+Ub6Y15ZVxFVxDesRfAld3hFPWwANG42mjU5TZpRrAFY
	hx3O7HvDO1acBxLBYT++CkZm2cSUgvLBwXaTkzlc2T7dIBKRBnei5ehx
X-Gm-Gg: AYBFou2s5USCi0V8Tjg4PbY6jZ/bAekaAN/TcVe87svQqJXy/ItLzoI3OSpqy2teoN2
	hHqHoEEJxBrCjyVc2IYwCsT8eRpENWo/WIgjP/afuiY6mFPJLXIWbzZjkvX41zoLJgBmXaDqgB9
	+fV+AyQOL2nvDYIDI7Xcp/eQuKl9GjU98gS75BG/p0Y6CmO+MI612Q6RKoC59h+6i+ZCYrRyfyD
	6kI6j1R9pwRjRrNGEHTiaOvGfN+/wWomdzUo6/sm290EeV7xVZ5WPo9JdkK8xCaAdvyoUM4eOwf
	PqdOREfvevlSAl2YNY0XTWQPdlq2txxnr4LuW3rAbamtzmjSA+Fea+c828Po1izfKET1QRGfxhj
	NpCrhf10HU/FQ4RextdeBAH2oVEs+cOQB0U0qRu6rYsT4bFOvUPCNKlBb0MfaWVVF44i2nL+QXz
	iqhnDFPX2E5z1mElCWWqYu7rv/a5LClu9ithwDDBtbX8Io35YTzoSinV+uIHGVZpX1C8fP48c9N
	6ABwtl8e5c6ZbcN7LLnshBHEznV9wNyejhDVqGnQxKoOq5c2h20OaqOJOMk2IJLTIs1zuSzm1bX
	/TwQTi+JZwEV6UAzNErgrDhZ/WzmFkc+PwgDQtS5+ZmfL8sdvBkriwTGADRPTNF3kzUGHPbdlo/
	oHVd1TTvefSQmzLFihfPlGob+fSaIAe1g42yhr9L7Fl4qMPE0wieiFSY=
X-Received: by 2002:a05:6a21:b91:b0:3e8:e974:e45a with SMTP id adf61e73a8af0-3e928e26581mr4547143637.63.1793466186813;
        Sat, 31 Oct 2026 10:03:06 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadad94a8esm817264b3a.55.2026.10.31.10.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:03:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:03:04 +0000
Message-Id: <DMJ6PAVGV9ND.29T5161F064JL@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire"
 <almagui@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 <linux-kbuild@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>,
 "Martin Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: check CAP_SYS_ADMIN before looking
 up bpffs delegation names
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261031130959.23472-4-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com> <20261031130959.23472-4-wanjay@amazon.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 31, 2026 at 06:09 AM Jay Wang <wanjay@amazon.com> wrote:
> That is free today because the vmlinux BTF is parsed at boot.  Once it
> is parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this
> series), it would let any user make the kernel parse it and keep it
> parsed until reboot, which is what the option is meant to avoid on
> systems that do not use BTF.

Any user can do that without this mount.
/sys/kernel/btf/vmlinux is 0444. With patch 9 one read() decompresses
5.5 MB into vmalloc_user() memory that is never freed.
The parse is the other 2 MB.
After the first use the kernel has what every BTF=y kernel has today.
There is nothing to guard.

> Check the capability first.  An unprivileged caller could only ever set
> an empty mask; such a no-op delegate option, and a malformed value,
> now fail with EPERM as well instead of being accepted or failing with
> EINVAL.  Privileged callers are not affected.

That changes what user space sees, with or without the option.
Drop this patch.
