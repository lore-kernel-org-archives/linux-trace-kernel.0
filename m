Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74967336885
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Oct 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009147; cv=none; b=fkg3uXsvG5YKsr9Hn4lkS9qTJxZpbFgEsEcsW4grRGe7LD6gfDL/PbxB3Cx7YfVYJafm72JidKTYfTupFFs1OcFNzCmfcdhVBzdp/n2T6sJnJciM/8MYgAd2shdjcoS1HIIp2gprc1D9J+Hirn1cyHb0OBr5cfekA5vIhqLE2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009147; c=relaxed/simple;
	bh=VuiMGsvrxoxHYIMjTtEAMKJLNMC58E+oDp1FFjB26XU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=G0X2MgWynL4ouuBqiRMlSG1qJ44xTvx1513HrGPm4QESknLbr/gTTuZRVsohWAD34RLvE3be//KPlzfGyhIt6w1cUTDAYPecR07LvWbsEDcgnra/Qzt8nY4//YlELtRU213JpA/PeO5HB47S/fBMZKGAbho713GX8OnXD8q+ALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL3guCmC; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL3guCmC"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7901f7971so44633a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Oct 2026 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009144; x=1791613944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=DL3guCmCAoGGad5fqQhT+5W2N60ezuvD94VtFpob8EDuN/9oZNMQlKHDpKAkIFeIqv
         cOYuDc2THo5GGGolhJh0u08uEpd/a0aW2pVhSbGM+DGfgBTDKm22DxkQ6LX2FkKiM7yS
         jJV/jTe/NGZqAqIfD6TfS+NvtBajMlBp4v/HObTFUIzWKLyviiMPwG3ZAouqLj26zAwG
         ZcJjzfa+1isefTBiR26J43dKgCqETQBDF8CPhVZde99KZyOFaecA23+M4lrbFKXIXN/C
         dkTOqRKnWejNq/nzi8KHvYZV7R7OXmRw9eMk5898z5VOh6iUMuXoiZABMloEUTphOZXz
         PHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009144; x=1791613944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=seU78dzSha7stexNcvW6leeqsITI/pTl8EgbP7OZs86pBgoYqajcqk96U7oWyMRkqG
         9T0oGuMjtez2BFfQELJ8bjq3dLDlgKNdIFIJwIJhwLN/Q/06JBrOgvdk0XHd6wjaHL3f
         9MZqDtgYhuPLT6lhwC/Isi7QuMxT6jewPMnjGZHcwHjyvgVnVbJodXiPZYHdbnxenb9m
         hJAEdOmo0Gj2tJbjZ3Fd1jGgrrPF0RUdq0G3dkBgftvGkwQfJ2EIFk2L3N6ba8WFfVzB
         NLzFWBajtNN8v2LUQitamOVSljlUKHOoqwzYOE+7mF1Zs+LUJ8+7v2bsJVLmcRrtCbul
         qrKg==
X-Forwarded-Encrypted: i=1; AKwUvByOMzftuoHzStygaVTtExNWZNZx084FJNM6Uuecn3e7N0nNN+3MDv+DIsslaEFN6AiPjJMkEYyFfLqEmDU4WCwfc50=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqjM2e/oICI64RnNMqM4DGEt5NURl6IrHHONskk7i9SmaIGC19
	tsUKJySRuxhO95QCcIjQYlRYwguTeR9BNi6JpRF7hC4n91UUAeX5o2MX
X-Gm-Gg: AYBFou02cZD3wbayybyPWbP+8Fbt5qWvHSVO7uhL8eRYqPiEBhjAKQl+6mrhVBf5Wdo
	TuOF5zFAc59rpteevSinV3bOwSveHWIbpJIqMCtYcwNgjzy2bPebR9kWvM10V3WGstjIgHXr6YI
	ctYNXXpTMe4sLc+hDjZBQnhxTyZCFXMEDSU1NicHhYDZJKxao0hCmaruiUAZxKht+Y2E9ZuyKlN
	Irs3GH/yMymgqXFUruSwyX0QTQoo6c5RELTrkTLtUgQRiF9wnEV06l+o7w5/bSclTa9Ifhk8iNH
	u2gN6RkPoJ3TC2uqw8FLKqZGYSnY6aEG/wbSLygbetuCtSYFm6rerv/FlD78Alqz0Y8Nm6DzwDV
	qJg4/DsEHv1Cc0+2CQ2sTZUUvwhADbCT8pVmH9uu8+/c2ND49DEM8/ZC0AVYbSuyqZj13cVrnvs
	1WD24y7q2TgOPabi56K1v7TA+X5l7NrdWoRb8EL9CS6ACCJfh9dNiXmUnPu7TOm2SRczZ4eEdN1
	UYKmMeryNJ7tQgAPrGy+/Y5r79V9oY9KHWABofdrdGlFB+x7fXdRQJ7cRktyXgSxWGXLBIdV0O+
	WRZfJ9DgXL7SgQ==
X-Received: by 2002:a17:90a:1650:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3a6e622a50cmr2049092a91.22.1791009143685;
        Fri, 02 Oct 2026 23:32:23 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b5c3dsm1823004a91.13.2026.10.02.23.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:32:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:32:21 +0000
Message-Id: <DLUZR540Z45R.3RTC4COS2IW2V@gmail.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Gow" <david@davidgow.net>, "Petr
 Mladek" <pmladek@suse.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Shuvam Pandey" <shuvampandey1@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, =?utf-8?q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Jiri Kosina" <jikos@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>,
 "Thorsten Blum" <blum@kernel.org>, "Alison Schofield"
 <alison.schofield@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guangshuo Li"
 <lgs201920130244@gmail.com>, "Ira Weiny" <iweiny@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <nvdimm@lists.linux.dev>, <linux-doc@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] seq_buf: Add seq_buf_strlen()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kees Cook" <kees@kernel.org>, "Bill Wendling" <morbo@google.com>
In-Reply-To: <20261003035906.too.263-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 08:59 PM Kees Cook <kees@kernel.org> wrote:
>   seq_buf: Add seq_buf_terminate()
>   bpf: Remove dead newline stripping from format_disasm_line()

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
