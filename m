Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B043803EB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222409; cv=pass; b=aXaGuY3iGhhd3mwBCp78PxzU+9f/YJPEf/JqUYDRuKAKk/DqbrfOnXgM5yKwWSV0IKfJCS+iXQdsJP2I3bdn0uae+DEiPyoyb6KiCIwHEINkDn7EWlZHisX4uSaOLJ+Xvf79et2VnalX9B3e9yfugVxFYCoDdRqa1i8e4MERDvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222409; c=relaxed/simple;
	bh=WgNPTyzJP6h+/loXvXxBK9obj+cvdvHP8r+IDx+BJ1I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+DZ3NBVnh4ctuQa2TLWPDqqatMh52zoQDO2M8tNX/iTK/wVa7m8s8RkEN8+DFqSMB4iXhRsS+oiYbrlAIE9hI9ApeJQOxAqy3X372KPdvuqipEntgqQ1inNRC3U5XoIDDtr5cUwx421zoT+OXjtMQMvYh5x+GwQrrsUhPdUz6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5FFJtkQ; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5FFJtkQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca965de53baso2056345a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 10:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784222407; cv=none;
        d=google.com; s=arc-20260327;
        b=MjMJvtUkCfIphL5y5sMyIMePW1fa4/xZ8c6gZGEMnyhgH4sKNTZ8LZSFBHzYczX6GB
         KoJJTFFAKY5pFxiRaM6qauNjIdByZYrHYWNc+jwllpa7EBEIZpQN+KY3IJnNDObSGzzx
         gAFRsa/ggBtpi1A5uOOSSFDljsGMYtlSmzj7Jv99+yhDUxxp9riHnMXR/AoMGoBCjXin
         g/motMCmRXhZ32lKVFzHmWLlXvqQbdZbRk5r2ZfSrZjkWUhRWctRjTRKhDmNqHduV/eq
         mSTD0qXEQOJuXCQqgYEkRz826ViOGO5hkxN/VUYy7fpV4uQmsGJia/4xwOukqc/HYMEI
         amuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hDpH4vLaInenlGkSSwc32ERdxUXfDeJnyW2zrivGsV0=;
        fh=wWBvauNnkWPp4nhoPzg2UaYEjkNHVGpphIadFgbGS64=;
        b=bGYm9fXhIKXzK1cK9Lv7eNibJKW1mOwRQh0SqbuwiKzGSG/yNMnYhV3COPdneXsKRz
         NHVEdiD90Aye7rJqNVetc4vZP2/jXNNv89y+h1lbtJNhckOFvF/RhBki7zWQ/d7A3xb1
         90D/M45QVxd1ALm1yg6m8usgCXHHk848FqSTPhmPQ+bAkZRKuWYaBGGGLa77sMg7Nd3M
         e5vzPyMEL5c2ZxrBfgMDATa7DDNP+WJe5tcnbDEAZKaL1WtRPXI9yr4xWS/xa9phBYNM
         gztw0jU6L3GBZcxrMZulY7m5fZGuoNv9riK8hh2QhQG0EQR1db2kQ5o/YartnvOwBskv
         hdAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784222407; x=1784827207; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDpH4vLaInenlGkSSwc32ERdxUXfDeJnyW2zrivGsV0=;
        b=V5FFJtkQtJ5Of38LJ1sNYFN6lEt2zSeQlQhqKa7Eztd4arzlzvQYtO5vQms52mDfqW
         stQkSkmY79dewsm9D6RGU0g7NN2THOzuBAMSs0vUHPIpW/kDULG4x8kTaZLXeKjahtET
         hSmaCIzO/vzFMdUWrz9M44vrBs0Fv0XSLP8aSVWYsW+kxT7FnW9bu1b3++B73yUKKlEc
         IZWP4d8IXEcY8zl9qrszxW4PholUJthVAOkvtSrTXrwE/Am8Uxbsjau7q4gh199mfvg5
         PyD+eYQT890r3GNeGACnTDNovfBDuQrxrAcBNcpGGdx/yeSkTWLApNwfql7QSPVYJYfB
         7/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222407; x=1784827207;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDpH4vLaInenlGkSSwc32ERdxUXfDeJnyW2zrivGsV0=;
        b=PUOeaDjQjrlHI8rBFgzQjR86F0Ou58eRiLZrqBe2iYeq3BOeOsb31HgkJsInjDmNf9
         wifKnM9mlOHs282fKsLK1E34zw/rtZ8TywWbFVmx1av9WgHIo4Q1oqzNqCqBY3ITJWDv
         gYn2dl6WdngiUcjs8J401nATUjdsJDZf0eYIPiK0W4Z7Id/0j6nuuhsxJGhjbG8BRi3u
         oPMcMz3SvZvFDm6XJcefQfQHOFAjzk1EC7mT4gtC0pq9QpiS8y7CYouc0gCv+NyAFWas
         iro1QYvarOJblxXG5xx2razj9DRy19fUypiJ52Awm3HG3owGIHs4Hjb7KRUEpidA/WFE
         DZCw==
X-Forwarded-Encrypted: i=1; AHgh+RpiQzoYYKXFOGbHo1O4qF8SQ6VrMWtNil+rEnDm6eq46peSvdrDE61dGHKStql4XlsSJj4yjP+/ePFPS7E3BAt/jcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKG4CEDEj1wXKwce1CkEpq0ean8z9IGLm/dFYw/tbyZ9tgEUM7
	Gf6BZ2F0vLf2XyNA9kCJMISEmBra81qy6LeDcxVwvufiGkaGzeQ4Xgh560vhmQuJ8V4SnJeteHk
	NrFPANEQScFvlIV+QFTBKpGaAmBckzphtm/kafRdz
X-Gm-Gg: AfdE7claopG3pDo9/VEbR2m78FuvJwG/Jlfo1FXLs7Wr2PBfb3oEKMBWLErCm7Cm4jC
	acxaGXE3T5rQg0ofckah25WzrAILAbF06tYo86uaNXZbv2EgLZ126o2Eii0qTYQ5mwH6+aH2LHU
	c8kj/IMpMPcX9SpK/F6mWjSFf375IzkuElB7iSGQ8f5wO+7pSLe22nCBe9D1bYax8zAb79aRG1S
	dXg7mgW3UuMeVKrrK06Xfql6DqH3K7xwcf/zy3Qb+zQVD1ESa2ikNXHkELgN0sdQQc2QrN4Thgf
	NBgRfLTPyZnz7fyYIZ2UyXwUTHyG2uUIkHHkCy6qO8Gf+5S4
X-Received: by 2002:a05:6a21:7482:b0:3bf:6c08:2b2d with SMTP id
 adf61e73a8af0-3c3a5e7a4fdmr21247637.53.1784222406715; Thu, 16 Jul 2026
 10:20:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 10:20:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 10:20:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com> <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jul 2026 10:20:05 -0700
X-Gm-Features: AUfX_mxBIq-fm92f37AIysrX2Jjvm6RrlF5jRh7Q3ctlrGsM_3yjDZToekOalgI
Message-ID: <CAEvNRgEjPA5pi1RqpQWgp_hH2HmSnGhWaNiXtVBJb_VVdKD7qg@mail.gmail.com>
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Introduce function for KVM to check the private/shared status of guest
>            ^
> Nit:       a
>  > memory at a given GFN.
>>

For v9, I added the "a" in the commit messsage body but retained
"Introduce function" in the header (save characters, and make it sound
like a headline).

>>
>> [...snip...]
>>
