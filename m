Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068959;
	b=ebzHzSySNVNbwdAuvkLFn9stO+iAWgajaNqg82vzt4lVH08H8YOx0OgnIxCw5KEImJL1
	 R0low8MniOWQ1URrk3qztQVYZZKvHUBwy/CIfganTYJBPXvavAyrXQhqmZFM57q2mzWI9
	 MlWm8z2XX4/i8+e2ReQ9jZMIaPkV8435ojkjNvtrqgoNFOLQGq30FpVEDDVhkhLebicyo
	 8iZKPqRb5I15unsnpEwnUvd8ceqie8IgrPc+Tmyg9ygGM0Qsv2DqHLQx5RnIb4LDEUpmb
	 4Qs5FqAObDQLgA6r5YNuJ3Yoq4JhPd5ZIkKRWjHP1wJ3C8WkVxDqmpD0AI2VWqLP2fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=E0Iv76sc+++tRmnOuHNyMaYYW6dbIN9aWH2kbFTZy/PN2ma1J7cvXILh5qoOcppFRf6o
	 rLSc33+eBW6DahkI0AGbpanVU+NwflaYjghfTxu7gK+oQm7LZKmPFn5K4T34KLYd4ZNpx
	 /08OTnYOG8rQzXRyP5dH6BzC5ADmheEV6LmfxU/u/m+6KoAHFjI7cyKrljgokHyKsiaw6
	 te3BVtbXvzX5HrHTBAqjG9alQzGrWGPT1pYkeFe8R6hDUL3OBtrX+J4vljZh3JgZmlkkt
	 U3JRfCxsRTPT79xoUu7gndWhfwFB6VOuS3NnhWerM2kVYWddUBvqggNHxmJa9CQb7Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF3606A323
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 02:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84BF3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1846bc43c28so4071761c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068957; x=1793673757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=nAMLJ4pov/UKnTCLgH305UyFiee1Kbb1n3tCzOl712VaepOkFQaBHOfe8TqG3p1lZU
         FcmqVqrrqUreTloBdzXh9C3S8RzvKdqK0Wdm3ymTtA2e7F8hg+g3tAXi0qMz5tjjKhfg
         XZsmI+gaR0xwl7nmIQiVOSWVXQuFdQ0nDSV/JTrdP8vh+zCmGEp4ByKhGzO7Q9EFAqG7
         Z9UxSRbzl1SyjYddPBfqeotnjUxiWUf5QMQHMI+2cHXwFS8e7Vcd6faApvoLAEI8hyVq
         H9p+0vB8HKXlTDO8gBcIdyEeUOqojMCpKudjjewsxrlbiMp0bSMq+X14CJGfZa/XuOHM
         djkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068957; x=1793673757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=eYb+vGqW2z7LH9IfqUdie4cSQzIFQocNsPBV5Zw31Sy1ZJlo0f8IY2kcuEqN1DAZf8
         S5ksVO+/j2SFvC1xecahEI4w6RrC2Ji7iDcm74FUHz1EBUuP7sFk7RXGwwNsegElzojR
         usaSG/BOVYbCsfYsHsy7ovT+hKg3RPbAAhJf8E5Dz6OP4t+75+zwUYOyF4T5FyWE8bwm
         HG/CFY5mrfMOLlN76dcxAD6RX8StSKIXscBCMNorbgJC6pSwZnJlQcuRt94/zqbwrDjJ
         WgorKjO1Ja/JM9aKjChdnJJkUVvYURIOv3ABfHLuoUJhpc/BusmPlV/egw6Lwi4J7Ump
         mNsg==
X-Forwarded-Encrypted: i=1; AKwUvBwBBejQPQRsh8vGdl2Zv1c0VrS6GtxciQT04dgIfKLNgoPzPte5NN+MV1iMWVjuObM53eikIJ/WWimuIDpsRRdrM1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJB/dxU5OFbkId2H66sOTz+d8mrcbW5YUtOj154bRubJfmgqgzN
	GvaVaBDSlMQRaryH21xjUfKgPxukWzu1zukLdBAFRfNgIuFlDj4fBlYidbWiuURAINA=
X-Gm-Gg: AYBFou3mjOse6TDB1hitUDQf8jgpSY4ak03VMRTNVCs8p7dMrDtRVN6h9EFrQ+agwjd
	blU4cQAyB70mzTHfzzNrL3/BmqalrTQW0gvPXnAf+I/8fN7LvkdAuhabJSd9W4yxLw9lnHrgXWi
	AtvwCbcjhTAp7cZv7Q35jntQ8qAyL7a9Qn8YM1uonCUpGMDvMujJUyV5bvoX7MuUQAl/gzI9hPD
	BbGly9bh4qphCfi2ovUW9CbBNtqWf/sPQz/8Ms4wzb73zOB211pMcERZcBPQjZB1rRPCE08imxQ
	Z+KAyr6Z6x81e9ObR34d4Q9ir84GcoUDA81+nPH2av7WnQ+eSHPrj2GcFa5j/s01nt/vi84gytJ
	aAwqqfjUJ9MtNbxQtBmOe2juf300s+OZ4OuQKmXBOjBKbHQtXnKw80Ajn8uahU0yM2Wvbnrz3i2
	+nM8KO9yFYlsJEjmDC5OLXfytOK/jmbm1BvHLVVA8u7N0PaZC63+NMoWco6TxQp7AicljPvQC1o
	tY/vbNYtevZXWxptm0jg2VFa23YbnzHSX9P+mAcisoOa1I5GVrVZdORjX0+Nc4bLHyZ9wLvO7rB
	qFmIe1w+/eQ/SxZNMJAPSsgZ0aaDybPokfDEJbM=
X-Received: by 2002:a05:701a:ca07:b0:144:fd7c:84fe with SMTP id a92af1059eb24-19937307669mr13761314c88.35.1793068957501;
        Mon, 26 Oct 2026 19:42:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm59514670c88.17.2026.10.26.19.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:42:36 -0700 (PDT)
Message-ID: <30b1cf28-61e6-4f28-8e28-79815bd87617@kernel.dk>
Date: Mon, 26 Oct 2026 20:42:35 -0600
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user
 memory when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-3-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

