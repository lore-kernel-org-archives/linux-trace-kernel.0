Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123600;
	b=BrTfk1iqbEcg/p4ICZJCiVe5ys3b6YE3AXuKtF2wCWzJR5W9fvmc0vq+ID9FOtymw8ir
	 5QQwCL5Gw32Z/1TouZb5QlRW9czsR/KCgVqphikokKoxRe+6hjBnU3OUBJuRDuBdLEUbA
	 68FWWDJbly+2z04BuXxE0WEsK1ltmYB7r9HjUsE817e8Cj6JSQzaLBPSMJ+4Rjq8H8BbZ
	 aeYOq6hsdQ302aRHe9/64eCsDhriMCHIUtdU9z3j73NWcs4zsam7aIWDpR+yCwIio8eVO
	 +eUknkPwiPnp84oeYpWyo4OpbAy98UUSHxs00YRoHuXJUzmHh8uiJcVsS5nQni/bLaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
	b=y1tTH8GQcRMH3L9WtSub3oyD59xxuQp8jbj4KKMTjMwbMD73rhRQsJslTrG6lgGSNsR4
	 KGwPgazssOeyX0aq1RWgj0ZTopjGwwXUkCgN1qUJaEQ4ftnX5j4C/OTC8EbMkSNv9PzOD
	 ZoLDPECAsN7DCLArTfz87OaAQNhy1erglpmg0ZlZW/53JHOnBxf4ocG5FK23TGRkyjp44
	 rD8z26GKfsIza/xqmoxZvYB/JcTk/GCxaDREY23RPhbokCsR9uCGjAYms3/etOBamZfq7
	 +A6huAlu5pKvfAN1MRee95g2B7kdecK7Ek7g67BOWx/Ewg9XCQQOvLEPQlipvENh/wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA6606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CA6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c46d41f6af3so13862966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 10:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123598; cv=none;
        d=google.com; s=arc-20260327;
        b=nrUcFspkiAzKZ0+TNLoSFh9xT58H2lCVw2CiQ4H0AY+wFYVJJNde+GhONyjBA+l6TW
         KJRtYYLBFVTmmDOSAfZSNrJp13i5yfsZxMvPSNDxoLLgsTIkFXyozYWcj2qIv8EyFxon
         rFPaUzQcEjvkafOR3jdhXwDNTA4v/LcS/b6EqUnc5ULO3kQGVISK9ZboStSSCX+06Y5F
         iejMpzPhewqNAJRCKPi1ga9N6+7J70m17jEk1A5ubL2ueCYKuIAi/yiF4gY5cqraXUwm
         YYc8oo6I+tCT4wF3OSl/y230isnIaiebM2SWgCqUBRlfHnsARIED32HXA42XX/JRdQ3q
         C7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        fh=VOtWngc0T/NzjZ+HDzWaXJqEBVFVZhooBI0DdWUnR8Y=;
        b=BtzKGNqcN+8AKzQDvXQVbfCso/8ep/EBpeewT0BxHKQ+SsL8YBOTkCvyPkUM9F12RN
         DwL4KRkgWz+N7rl+NW5wHu2WP2oiZsYRDFqkuptz3OuiAGjqsRDO24itIETm1g/NrPVS
         moYgShSKPl/u0W/84a9K29+VRPd1nb2AM40BFSCUToA2E8cSxlMom3uJHnwz9W6pEJn4
         6EQEL2k4w9mGqJP60hvA7b6F+lRmtLhLXFST7SZggKVwrsAbCYn79bXsCNiqol0a5u/J
         9csrdKdty7xESOLgnSWwnA0mg/Qhf73XxtckqVgDkdtqmqN21JxFln+NUSCmWQvyWK3G
         mtzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123598; x=1793728398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=inJR6ox6aQPgzkJ0wZYiPBugaLW1/kUDoRUxznaXNPrxE2Wn3DkQl3afONPaEwO9sl
         vnrt6FP9OFfRf9KWlwZNng3ZlaCrfp3bQxPXGc+Gx+AORrKLJ8WZpN9m6kJEM6IAqHPq
         Jk4iMXPxJgkZqxRsoYIxQcD6CPbdcJbwTT1mEJs9Oh6VfooqjmJi5DvsYqRTbZ70S79m
         W2gdT7rvplj4k08tnzQQgxgOTLo5uqZ4a0mScYBLYVaYMXTVeZPwvd3azNIWeu6/sXO8
         zyeS5P1gD5N0vXZJTHB1IRGypOyTZEZWjLyDPXDDqsHxY4MhwV784zCuBQDBJ99Srvxy
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123598; x=1793728398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=BTlwaeCpGaxhzeVo47W+G8iZ/4Q1fYqRryk+StUD9kehx92Ql369i1qKLLoTboY2IF
         /aarKm3KDf/c7I5E03pL8zU6lfK8lvo+M49FwUnmnhkqZgLZzpyPP8pbPxum7Qgb9nCm
         9ThCk26M9CK/d2EDMJcpXeM8FEkegV61JEsqOLX6vMDxpyG/rwibwI7RjcjVmDj7MswA
         33u2Bds7s145hvUZyozgEUMkXMeVw9WV0sBi98GYIulccOq8BG3frTYsSrzwi5GTWTcx
         QMcdTlUQ7YADbLMkvns39Q0cv/YM4mZ2Zl5JypKhG74fkjK32VzzjZtdPZ8q0vlYnOEe
         h9og==
X-Forwarded-Encrypted: i=1; AKwUvBw1RzJ6Gnkq/2EjAU6+xXA3padNowUFaR0FnEO2qolgOGGz/egraBv0o72TbZhRLSLIYHGVJbzVO4TNAa0are/tFUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC2zPh6FKweTcA7T+odyQVtjYE5tcg79L4VZCzwjPMc9gs2FcA
	izRqHAUaGBlMDDV6uuTRTc14uqk7NIU3GEW0f4PH3dKSq238kVn40vnFDKxveqjYfcUD9yxaHUx
	1w2V1CozuqZxerdAl46YQ/MjrxSVjRuW6P+exEVvA
X-Gm-Gg: AYBFou1rMm484S2aJphv/X1UcEz6m9HebAzBCAt5TMebXY/BM2DJlLw0SJMolRQsQtw
	kAuEkeJGjdIdmBrQ23SbB/G78jBo8HzMwcUAoqjTVEYfm07fi00QBSx5Jt8JE/+YbzVT0bLW8wy
	tYqHW4mCtrjosqkazIMA6jHs/1mBLryaBTABwSQIdegl/Ok0yLXfp6Ey+8rXikgG+EVuCUQnHeF
	83afD6cgPmyX8pJ0TMM4jNd03YloAzvCNJ0mvClxAMXMSvHnZcZHyfTUVLCi2V235TRqPMBHla/
	ukfpgPsC78is7do9XDTHz0rbvmAA0wZ3TZYgP72smDXVmaF/Sx+8ilC7YGvsXdE7gLmtGtTzOf0
	ovyCxaEQU8+FPLwgJZTC6NHgsRKEvmk97eKg7ABhFvdgGY/f/CMyVhRfGszBnU5BGKuR0w8RmX8
	81y1jNJ6hK1ZfwOiTxlqqR9Hyy5rpHwziSZsRcH718iy90ZqbN9PNjDGPpuUtB4Y4L11LaOO279
	JIe08R3f/rg7w==
X-Received: by 2002:a17:906:dc8e:b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c46bde8b464mr1159692166b.38.1793123597614; Tue, 27 Oct 2026
 10:53:17 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com> <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
In-Reply-To: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:52:40 -0700
X-Gm-Features: AclHuK_7gnb7g4GjAy_SA5zcAxXhabVZixR-oCAtO-qS-tkfEqOEG_LlV9pvyY0
Message-ID: <CADrL8HVgOYb1hzWDJzm4sCrEAR7PL1xBv-1zTGebTusPoDsGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 7:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks, Jens!
