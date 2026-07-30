Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C833D8901
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450671; cv=pass; b=IGbeTdILUmyl1ZpMke/ZbOJijVU7GOPqm8NGfQP4qKvMSS3PGi/JDLDH+WaZsnwCe4yCNW4la5OOH/7QaP0SGz2rpi3z+6XTvvZcyScq22Wo101FA+1ot1TfKlPzQdba8ugTvsMTiEXNBvNgUU/eYmlqoOunqCym4sMWEYO3KcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450671; c=relaxed/simple;
	bh=RFb9jxFt+SB050uUN4iOEqSU+hhGaZfWAlwTqxcdY2s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdiuhupdRhAmxVjcQy39wuXTJzrQ5h88m0HZcRbMjqFUdVgQBIEUOZs4mq3+VccwelIKNftz3BfPeVXEBaY+SO+/cVx1eWOhD4sGeHghEaaFhG+ywmrSXRfKgMSmBmirMKtVJFdCv9M3zISOl6a2e3LX1OVhfABEW/KEgLPQ/S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyX8ta1o; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyX8ta1o"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38deea72eebso382244a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 15:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450669; cv=none;
        d=google.com; s=arc-20260327;
        b=g6TSXt+GmyKfDztcVbSzUKu0ZzgQclPcDKxxg64m+T1fRJ2TDN6OCkliI3JE+P0xcX
         uttD02Cq+dWqOZyybp3F1jJpRYXQD3lYMUI2TRwQra4cCSVENZR7SuTO6UpfzVVJTv5V
         bw62L6T3Hj1Exl7KorQlrwy3e1fSFX1jIXQMv5QujBTHxl9cg1QXVtGz+HXr6DddAFbj
         rci9MOcSEd5eJCYm78SNzBpY8JxcMe9H9uEb1l+Ez2xhAAh78QS3jjPPCOsJ5DnspzYt
         ZhqaZyi5MCxGKP9uDCJbagrRLZPialv93whKdXNDpER74W5PSaUOjpU4QWaphoDYZDpO
         VUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NT7QpFfx9ePxD+EfhDliJc1nWKGrZODd+FSZ20/4RHU=;
        fh=fhBAMGC7N1vhvqtCFMiYTMPwBZJ3IgM86ALi5t5C3OU=;
        b=eshT0ynmskFlbz8xA4rmat7n/KKeFxPIEOjstP8e68RRE/T9Xbru1cbDukqJeW8rJk
         0Epw89rKFY3MPKSpAIQa69Hr5tBGKP+Dek3++9PI/11H4sT2GE6PKc72mkNq5hKxkTi8
         1a6Xkdwc1bxvw2QTJud7RbxWCg/mZkU/YddpJLBBx/n036dYHAOpk1gqK0uVOykH3cdI
         Vw6lIOViBnU05QyMdTFVKd9lapn+H30fKfboGkvi58E33HImrdVDUEKMpGcApf8MBme/
         m8MaDFsuugItstK1+1zsNiEwNh4gBdizmKCAwQv0lzeKBAD5frniZYHOLWlJd5f3lzTm
         B0RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785450669; x=1786055469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NT7QpFfx9ePxD+EfhDliJc1nWKGrZODd+FSZ20/4RHU=;
        b=iyX8ta1oIXwTHeAbpQ9turwrD41nAuMnhWMV4eirv2p0xKFz/MQSM4n3C5TQm/1mow
         rImFsx2dMqgyRj8q9VpXQUyMoSiEDCDojWmqvMlzzO/na9zMRvemi8prn/dxivQ1QVMk
         LVZuPVBpUTYtxvVP7piuI1cQBARqDGrZHQgYQ0cLjjZKR6mnZ61yWzYHTD81C8u/GSUw
         rJOWb20U4q4G9HbgX+Y0kCM2ziLBG7EyssUbKsY2xyqR7wKLA7yxhVtLZc5VIeg/lPT1
         31OSNEjnMoCwIPxCeGs5DfrvnTqagmDPi02jt7IlsXbcgyyDp75AYtDjbE9k+L4M94c4
         f7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450669; x=1786055469;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT7QpFfx9ePxD+EfhDliJc1nWKGrZODd+FSZ20/4RHU=;
        b=XwHA2/Ny8fFYl/7ahog/Gadv/cmXUMFrXIQd/RGVQ3NBDLUSZExqpu7YFr6pF9TqB5
         FokggIVmmwXcQuJ708OrtaeL5l3SbyoGTLaoiVckvY9yYeawEf4PHZnzwOJrWyqhSIqn
         iuON/9kHnX5j4Yd+kgo2IFvX+Z3SbtUbNxgaw4MS0jBkxrfn5aFmTFfohE2nPysbjN+M
         C2xGDsSUFbjV1Y3JFx6ZEOUhKo2JoAyIZIm1/9E8dx9skxomMh+enq8ivLc0SXBiqZZt
         BqS/MCUR32WpEs5PL0HOHZ40zNkyx9zBkeqTYuk4O2cC/UZMo/pJqhp/f2youC7bRcm8
         humQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUKc081Ay5ah13YDkWaPuSzHTu9/++QzAHasaGmWcmSmuyfLwlK91BDHBZ902lt9GeqS0yjq6tk304uxosEyQygzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVoohvj0HRNWnClwH2GY5oIlL2ZbxkQkvxaGFEKwMkLL9SxZh
	tnM4CA5mOLA2hZ6ID1HOg+5wM/WEonjzOMzA6/C+i6hn2pK7C5Bb0NmO1rcYMUDGAUXkK4SCtbV
	DnJjKQ5axTpK/rtXUKUfjefBPVTKysmC/NKJbqSBv
X-Gm-Gg: AR+sD10wuhfdohyOWWHgMJLjpZlVV78pbyDvouwJk42rh5yWAvxScFDDf/5evIWVQ9a
	TWZ+qTbBv7NyOxrQqIpnzdJANXVDTqhb3C7wKDrpEjaU6WVYg29ma5oIQYFcuqZPrgbI8sJ7MXz
	I5hPRYPpQUl01tOO7lYEBjO4mmDMh6HKLFqLalZRbumLwYgIss6nEgXKT2ZIZyA7Y/0waEYn2yC
	QUFNWUl9SKfUfv7BZPnpr8sDdtO+AVo8GU1w29MIfjni/WOd3aTpUaL0JtbTuibGI4LPpyW+Eoj
	qVTagE0Pt73Im6GiRGZqZ3oa5Bpz5daYFH9KYs+SyHt6SdEcYgvX17d9VnuIBzoX+BWEs04ECF6
	7N8KJ83d/ue5t4T7pybiRlj2aZU3hbM+il3HhnO+belXQ5do=
X-Received: by 2002:a17:90b:3c88:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-38f9bdb3885mr3385917a91.19.1785450668084; Thu, 30 Jul 2026
 15:31:08 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:31:07 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:31:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-13-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com> <20260728-gmem-inplace-conversion-v9-13-35f9aec2aed2@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:31:06 -0700
X-Gm-Features: AUfX_mwSrnPTxdnd5yQR4dz6uVJVHdsuk5_VpYazXm1_NpOUC6lIlEZN5j_ISHs
Message-ID: <CAEvNRgEscmPoW2f4UWHnPub_ycDg_QHRR-cCU5yL9HXu=G-OFQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/41] KVM: guest_memfd: Return early if range already
 has requested attributes
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Ackerley Tng <ackerleytng@google.com>
>
> Extract a helper out of kvm_gmem_range_is_private() that checks that a
> range has given attributes.
>

This should have been

  Extract out a helper that checks that a range has given attributes.

kvm_gmem_range_is_private() was renamed to kvm_range_is_private() in
some earlier patch. Thanks Fuad!

> Optimize setting memory attributes by returning early if all pages in the
> requested range already has the requested attributes.
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> [...snip...]
>
