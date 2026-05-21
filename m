Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E323DB318
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374206; cv=pass; b=eNMsPO/8R9rdcP2T6sSdSEDIpVuSHD/GrXvXfUvHm7O1NmUc+0C4mPIVp59q8peGpXdxH2EHHqr5fC5sFvQk3RjMVPWmNnTsSGuAgVGTUeenj4dSJ4IcnFLsAwyAKyKfk03o1zBAM505bXf70+rciCDKeVwmVnCJ0Vy/cq081+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374206; c=relaxed/simple;
	bh=WJOUrtquWXGSSgTD5B2FX4mgIruAkhlJJ55ppYaE2UE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLfwjs+P/pW/2l+rfJAg90V8St4jrMJfShvUzUGe4Xpmr43YwHwA+vqe4Z9D2MKBySpEzOFBtqTmY6nyIXwgG3bkhyp0feMxBQLOUK72GYIPMbwaGfmFT3bVTAwpKX6Ux1ZpDyXdFS94CLYTYiv82jOMn8xzuW6z2rMquxybdKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CoEL7N6V; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoEL7N6V"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5751136c561so5496911e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374204; cv=none;
        d=google.com; s=arc-20240605;
        b=S+cFP88NTRah6Ly6erWlRlUudEs+mUlOLU1GNtz1G8XTSzW2Cfr/0w1oHSQB8iVczA
         rjnd2IiF/LR23wUZ3MlFlROBG0mzIW7OR/ali3pmzqiRNcAQdTz/btjzyUf6oz6AtDT4
         laOakJEMNT0ZDdHeyQEMdnAlAER8EjmZaes0sBDmCODeMvWov6uEwsp7DgFVoyGq4slc
         Nd7kEV9rtwxj7oeuJNTUZ0JspT+3kHIo487JDuCku0f6qRtlNCZb4LDK8tz2FTjVYZ3h
         F37Yf2kk5NJSYpbVbJnU0me+gEGji5roaLNJiVopxdv66gV59Wj2IZLgCsoG4midjd3Z
         K8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vYaUa4IMCMaYAyZ5spn416wLAd7Y4Wm0XOOfJ/wi8IE=;
        fh=OpeMS7LBkAX+uBHwIuiEr18j5b5ET1onMIudQRShQN4=;
        b=ERMr3saCLnaMS1XsMiWgyKTGSj8lTJYtd6KIRJIeYkPbzk2Pq6/qdv+xKSbIJio27e
         9X+G5luyqpMGXwxcQQmLGTDql8BEMnA0UNvnaszEWRDaa4d9HIxu/r70WnfBHuBAne5k
         9Tra2++N3e6/hl6lwj9lgnqaR0XLa6DsVnYYF/Sv9zcOWBYjZMyZTWvfSWCLOcRDiQ1/
         wkJOTtbBNBzhTJbI5XmzFmGAl0+jd+vf7sSYlTU7EjHh4Y1dpVE5b0zD8cLvUda8wO0z
         sygqWRQKMVt5939m7gz+mixayFbjisf/BQzkSK6NmtdTieZgYV19iFpWvnLOTTiOZSrK
         jf9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779374204; x=1779979004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYaUa4IMCMaYAyZ5spn416wLAd7Y4Wm0XOOfJ/wi8IE=;
        b=CoEL7N6VFzcfH1g4o29MAqfqDHbobQUgnRsFYEFyxcgHiaIq6i8t0ja8hy2gMeZTNX
         pobiKI5czhORZ9XHK3eMK4rv6yEZv89xyHu/5RcAoG99+BrbMrrQ+YRbmw4EnIH6Wr6G
         Bigz0XNdPbG7860tOBDlzxP6CLv6YUH0QoWP5uXv1cbvef5tQyhm48tK30P1uwMMp3WH
         XdHS4gC85eqIWE0G64VhbPBxz/IJWkZMdzFDCL0szp/Zzx5axFn3g1sf3vLmJkSblqw4
         HZG4qtUCXDypNphGxnED1NpNvA0KN7ZrBKWxOVvtZCMvddEq5Y0fwnnfkqq+jbtqUHWt
         FsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374204; x=1779979004;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYaUa4IMCMaYAyZ5spn416wLAd7Y4Wm0XOOfJ/wi8IE=;
        b=WLJG7zCFbdAiZFwTW69wIBRYgftJE0Ks+UBuyenkBReUIWKI2vx6NokFEknO4+TQcD
         eIEcP1EzuW9vCLTFa4X1tkqXVjjo/3VRzHjttPY3o578Q/c5nuA8DtN/tqyH0y0Cb2Da
         IJLtu9EnuKScba8tVfWs0RnmzPzDWAAzqgfD9gaelhwtUGpQsd3kte1mXeEoTLEWoUQv
         A0iRBGr2Eh/+fDH5oNL+bkeArOS44Dnr5rHUlkpOHPNHJFrHv+Honp3nFPJ3M27NiwdR
         7yEXc4iFmZPuCxFP0xbdV6NZVQWzyANCU+Ko4ElPqvNA8TASB5HoiiQ1kpdsu8wUAmBx
         jCxg==
X-Forwarded-Encrypted: i=1; AFNElJ9Dw7E3nuxP6aLn8iWxum1uXyRJrDDMLomBV+rDzajwFfk8rMC+Cw9/x+dKIarRlcUGXWk734gbOpDvW94Z7MGcU1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURM6R4aTN6x3f3fDFCsfutxgLPkuyN5PcEQARXmCT1uH6UW5F
	1KjmMYS201K2ntNVUYVu6DClPfl2Qf3fKU7OJnzw/iXWEGlJJoOlI7hVETU/l0JtTchhay21iA7
	zMh3gArg6BJtQAZcrAoRrY6wHBhs1QzxbvgUhaDbi
X-Gm-Gg: Acq92OHrMV/54ak4T0vlD2MR0+HY6shV1mFtDuHVPnUAD8Ahbm9idGZSd4hzwbNDuFX
	+QUdi9YD+xSMULBD1mTABBK9FIsA8TfRp5s8EsYjFEsoJULWGWNB3y5+WkSkFw+Q5aAnqRaZbSa
	IaotT/BEXplxy2hNh1IoHXAvPgKdMbLaIURFpzwjoNksnGRG5mAIhoH4Z3JzGNb1VhR/vy+sbzS
	6+O/wuy6OahNRVbqMqaaIYzO6KlDVXP01b4VNm61kouoTdcTd9XdSCd2xO8T5ubN0B6zOH8UZ6p
	oYkf/F/3hO3CPqMIvJbmNHHtLQhLPzlYuiVn5pput7gLXogQfw==
X-Received: by 2002:ac5:ce81:0:b0:575:a69a:a3c0 with SMTP id
 71dfb90a1353d-58412b0d22amr1255230e0c.7.1779374203234; Thu, 21 May 2026
 07:36:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:36:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:36:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTyaBpTYsJRRyP09YggoHbi6s-ZgDoWoFgDRxO5k_BkoBw@mail.gmail.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-11-91ab5a8b19a4@google.com> <CA+EHjTyaBpTYsJRRyP09YggoHbi6s-ZgDoWoFgDRxO5k_BkoBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 May 2026 07:36:42 -0700
X-Gm-Features: AVHnY4I30lxiEW6e6I5WKrwyQmuhxKDxlslbMLBEy4dCPODuZC6olFnz0j666eA
Message-ID: <CAEvNRgHBwVx+biHxTyNETBt1jQ9Fohshud1N4bt8beVYhPiOKA@mail.gmail.com>
Subject: Re: [PATCH v6 11/43] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

>
> [...snip...]
>
>> +static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>> +                                           size_t nr_pages, pgoff_t *err_index)
>> +{
>> +       struct address_space *mapping = inode->i_mapping;
>> +       const int filemap_get_folios_refcount = 1;
>> +       pgoff_t last = start + nr_pages - 1;
>> +       struct folio_batch fbatch;
>> +       bool safe = true;
>> +       int i;
>> +
>> +       folio_batch_init(&fbatch);
>> +       while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {
>> +
>> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>> +                       struct folio *folio = fbatch.folios[i];
>> +
>> +                       if (folio_ref_count(folio) !=
>> +                           folio_nr_pages(folio) + filemap_get_folios_refcount) {
>> +                               safe = false;
>> +                               *err_index = folio->index;
>> +                               break;
>
> https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=11
>

Sashiko's first issue on lru is addressed in a separate patch later. :)

> Sashiko raised a few issues here, but I think this one might be
> genuine. Can you look into it please?
>
> If that's right, when huge page support lands, if start falls in the
> middle of a large folio, returning folio->index as the err_index will
> return an offset strictly less than the requested start. A naive
> userspace retry loop resuming from error_offset would step backwards
> and corrupt attributes on memory it didn't intend to convert.
> err_index should be clamped to max(start, folio->index).
>

For these ones, I was thinking to defer all the huge-page related issues
to be fixed when huge pages land, since there are probably quite a few
places to update.

On second thought, this isn't a huge change, I'll fix this in the next
revision.

> Cheers,
> /fuad
>
>> +                       }
>> +               }
>> +
>>
>> [...snip...]
>>
