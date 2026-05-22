Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8E37DEBE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490961; cv=pass; b=L6Wu7kJkEwiYKf4p82LV6/fjDGs7z4v3cvfUmAH6HIAq3CWGBJoxrSq1S28PxxVdqHpcWtpV1nZyywubXWZ40VSLrlchsadtG3jsSaZ7QM+ew0eqvsfmePFSi8y5QSuc0JhGdWhBgJayN2krcvQDn67XS583LflzkqYQexqJu8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490961; c=relaxed/simple;
	bh=ibZMSZEwhsHjGnLBrHCL/QtGJncXCz0nJYgEJjvO8KA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/VY7NyyQ1PoZGqbxs/Ows7AcHtKO+iUE+sUkKBHt910xlR6Zxhh6jeedMFLeC8+BCTVRtAFZZnvP1nuSLrexqiGXTC61YmbGmmAJYxC+sTf7Xq400jpaCjkNz4+vBlRrE1t+GawlQMkh9UUdKSu4ARLYBqSACCMktzMH5pMOFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQgAgxjd; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQgAgxjd"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-57513a91514so2633483e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 16:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779490959; cv=none;
        d=google.com; s=arc-20240605;
        b=XDUhVpKtKUR2M1AyEH/hhV5yeZREDbVI+QrmbyGSUsVVHLN22wkGf+r1wtJ/g2b+0I
         HTpTD6F1zWCmB8BA7Ma2tBvqs32zJBI6I6y41rONTYSASdKUuDo6UH8UOA8hH22RPNSZ
         f3c5ikCRLnZf2M8lWzyJVzf0Yr+Bc7+0xbHI8mQ6uBGsgEYRkD3wZ4gs/b3/EWFizYqT
         5kf1mny2m809N6zfK2NbQrngUU8G+53ApZxagBRbELezRorht5BeVkRzGrsFM5KUgQDK
         kZWgnzSHml+qhKG3P8Fwgvu/jDOIw4h34JHZgvmIWRdQhMY7Z0m1lSy6Zy8p7rRT0Dgw
         z6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+lqWW5xTN76UwAfrRbxGlO2NBxcf8RIbZZTDif3+3JY=;
        fh=RUhUDAbgp8Bpa0PQQuc7VQ79CIjnJ1tU4JdNneuIBmE=;
        b=An9RUxv7iNYkS5PdAtxVmDiGdinbk7QRE6LD2ZtzT+IVSkRjeOGyEbWOA/Xw1m0BgN
         FjAxvTTRFjlx8U3sIr+FSxggZmJn6QPkoomGLoQh4KO2pmtgHwT0PvqH88ujN/DMhWEd
         /a/gZczRYMni+q0Bm1Ul+O7aRbs9spPvbk36CKy65B9/lMARtUtkPvFOdL2MIhyBT270
         2Mo9+CwzfnBzBtOxsWv5FklCTQfpWSogiD+xF/bFBJeIAPhmRRnswDH334eBHcmYK4o5
         VcehlPzTCwGkYrz4RugazdtULlZ7fyJXliK9XowoaUJTkYGuU3wihzViUxcoKE5wT39A
         NQtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779490959; x=1780095759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lqWW5xTN76UwAfrRbxGlO2NBxcf8RIbZZTDif3+3JY=;
        b=YQgAgxjdzx/T0WCj/Bi/gjx8L4ZI2/BWximtpzkBrT5ik/C70mWPd2OkJgjGGvhPdH
         zmxB5xtR6GHvDmU+EHbkRJNBh6TLKkNVzDeX+d29UjiSbIK3QGcFPNXW/GVTho3tFmhF
         ZTbgBSEyC1XQIo05GzG2xYS58Su6qOFsJQGaW9a+IQZhPSpOMkeCqH1uViErKDZBd2SU
         H7KcDoFVM0GQagKSWqtwDaXMefIeyNl6ugj6siiOKuIFhaTWenYXrnQrDOkvisFzc/ab
         mGL7evVPn00TMqeLeJyZtuGamzUUGWNLGtJhV6HlOGJen2br9ouv7p3beAG0xX6ph38p
         ymRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490959; x=1780095759;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lqWW5xTN76UwAfrRbxGlO2NBxcf8RIbZZTDif3+3JY=;
        b=WxcMKmfE40NtZhIu4IzpDDH0NRTujawm4Zf1PzGg0vXbpNfPjdNPpUaKetQo2yGOEH
         4tBDFNsf1pXQd7gJKLeVahsATiMGPcVPLkVvYqIa+/3ROZvF9WSeMr48i7JJGoPQrSUg
         0AcEdantrXZ6pXedJjTgI+5Yd4LBJPXNf1FGTkQK8oRb29uTyUvaPfg1GIJVQUvGzGoX
         T6QagjVFcY3Vvb+7dhOdc0paSSZHj6aPFDDkJAmDmFOcndFITC8TwqlExLB6rudmVglk
         E2yi1yZa892XpgczrW9FGBKK0BMSWiQv8dtWZl61LhhrzrblkabcF4p20TOApkoUxDC2
         3McQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tYmJ9pcS+fMX2SetARUvPlmMuAEuM0rJm12XVy77SszVDvxOdomTHe57jY9wpotPAnBtt3IRlyaINBwMEsHaP8Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHC5Wl/pUkVXc9/gotczfHcHYLoBVk0KQk0s907CI1kE6/vgRM
	5v/24peODihkIWUxtGui7P3mWdgCdbMPLl7FMhBFz5ShxOfvjna0WLAgh5KrTVRHNYGj6DoPZ5H
	qcMhKmQSJDSct3U6xjUsFO7fLIQI3W9nj+RvZQ2On
X-Gm-Gg: Acq92OGTnjc8fj/MXFT8C4RsE032pOK46YC0O+RP2zoTxesnFwS9KQsDcDthSr011bJ
	Kx0XYaPRz+tI8Da0nhq6mogGdTTZ3ctWHWAGwTlwETXKDDqcHIb/3VARtLcy1DbJnPl7Oz+py4K
	TH/0NV9aF2bi+wvKqOKTOU+QPA2HizIPnerpP3W49QRJvicv6NskOZFFajmKCScLWrvP5xhqpoK
	QMeYn47nzXx/yo6IZw6uA4joh/u51horRV6jPpUMHrVhfbOfyFNEscgvXcWwe0H9vMwijUKOvhS
	XXXvpdjrxFB5TU22P3oMX9946UPYVQj5O2keXTy40L9+eDhNve3oz6DBFZbhDq71oV64KWV1Ym+
	ZDlmK
X-Received: by 2002:a05:6122:1796:b0:56c:db8b:504e with SMTP id
 71dfb90a1353d-58663966692mr3461861e0c.13.1779490953839; Fri, 22 May 2026
 16:02:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 16:02:33 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 16:02:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-25-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-25-91ab5a8b19a4@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 16:02:33 -0700
X-Gm-Features: AVHnY4KLpjLWXQlawB-gZxOwicuZUmspmndJ5b1mQf8zRUUhG2Ao-NrVmxpOgcg
Message-ID: <CAEvNRgEHf67kpLtNyET7cvE5hWfXHqNrwv9cP9bRUgk_NKb+0A@mail.gmail.com>
Subject: Re: [PATCH v6 25/43] KVM: selftests: Add support for mmap() on
 guest_memfd in core library
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

>
> [...snip...]
>
> @@ -1078,13 +1077,17 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	}
>
>  	region->fd = -1;
> -	if (backing_src_is_shared(src_type))
> +	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP) {
> +		region->fd = kvm_dup(gmem_fd);
> +		mmap_offset = gmem_offset;
> +	} else if (backing_src_is_shared(src_type)) {
>  		region->fd = kvm_memfd_alloc(region->mmap_size,
>  					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
> +	}
>
> -	region->mmap_start = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
> -				      vm_mem_backing_src_alias(src_type)->flag,
> -				      region->fd);
> +	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
> +					vm_mem_backing_src_alias(src_type)->flag,
> +					region->fd, mmap_offset);

Sashiko pointed out these:

1. When mmap() is done for region->mmap_alias, it doesn't use
   mmap_offset. I'll fix that in the next revision.

2. mmap() may map past the end of the guest_memfd if, due to alignment,
   the mmap_size is increased. That is true, but I feel that that fix
   should go with a bigger clean up for vm_mem_add().

3. vm_mem_backing_src_alias(src_type)->flag may contain incompatible
   mmap flags. This is true. For now, when guest_memfd is used with
   vm_mem_add, the src_type passed has to be VM_MEM_SRC_SHMEM. I think
   this also falls in the category of doing a bigger clean up for
   vm_mem_add().

>
> [...snip...]
>
