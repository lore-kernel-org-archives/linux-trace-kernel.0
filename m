Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF729D26B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113754; cv=pass; b=OwPi/Fp0DAS1Umc2Z5PiUJLwkNieioLBv6PIvJK57s1Aiyx0HSO9Zs1hSkxK/l078lzZMqbEShosSaPPFoIgJnEDy+JnRvITIoPYCvotf9ZSLwLIdE99API9d864d5xFHvdmKX0BHLwLYolN+bj+2nPQ+muSDJiigz12FmaHQ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113754; c=relaxed/simple;
	bh=8/tcIFUyKedfnkVo5NHdCiAhmo6kOi7gPaC6gM41LYQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBLQ+kbOQJuiYO0rHN7AlejFBI4DNqLOa3rqpLvYWtQq9/CBR2+pz/8yAfI6YyvlGYsztJYOLqVFZbM1HE70zMB3EZzjvuYO13ab+hGtC0MO9VqH3+hD6kyLQcc26QjSG7WfYcNcyTMMcs/wlfJbCVqPq5yckuK0tdFgItwCthw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/Ff74w5; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/Ff74w5"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1382533d428so1604445c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 10:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781113752; cv=none;
        d=google.com; s=arc-20240605;
        b=lXuFs/2uXgeSc6RWVwAaCuBYA1UqdFRhMIo0lIoLAHSjYt3kOvZycJkvlR7ZaF3OQz
         DkzefT8oJvSqBnZxTlj0a4oTFmQiDfHy5X1jWTeV+Q80nHRg5FlJh/yeCMWRMuQlZ07A
         ddhzvyrGki9UJEjcuyfjoGlb6XiZTFT8UwLvFdSBsSboXnzZ5/33+u9cBgbStOE3IPK2
         9QUCjk9Oa7laqhmRc4cJeS8rVtsUzD5O6AgeHV985iyQOh6z65azMYIODb3CKiJWlwKJ
         uW0ztm8z8cAgU37xXFoTtXkVnVUUqcSXIS1uD4e8G4vlDTn0pT020NmhW4f9nBFKODa6
         OiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=46dTS54fJkFDX+n3fNAtP/BR3hdg+QzeIr8BMTbVi98=;
        fh=on99dgpKtxWdFLrEK2IB7euNodk5gxd4Tbe9vJtOA3c=;
        b=bu3/DeR5cPmgwYbUg6GuRNVtOHqibzP16A0IbyDTamgQ60tpY9N6daWiwjgKfQmcGI
         wrfU0TqYsyhUb9OmM66gvAdWwa+HgSJ+EQA+DKoCyT1s5Akejj8xZMZ4b/b2S1rHw3cg
         B5vhZXxWqwW4DJzCSUaBHIhvbpdVD1E2nupVBR2YBlBlWo824VuoIFA0LLDXLxInNeAZ
         cr9YoQCvoQYBh2RNeW/A4kd3RmNYsxUi89917F/oO3jgmzOj6h2ifILlKjVgcBQaqMp9
         ctwXtZ96iFfbaFgDCBCA1F91tU1CaUuqMR7o1icKj9Uj2pbdKsIjSbAgXlNwnxJSdKc+
         MgGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781113752; x=1781718552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=46dTS54fJkFDX+n3fNAtP/BR3hdg+QzeIr8BMTbVi98=;
        b=R/Ff74w5iOu3CBYtSUHmD687zZw3ZQuYuooW8hZrExGSN6YCEoTiLE+Z3XyUCoswCD
         gFl8EH/aD+0i7W9K7h3F5Co1Snlp5hGrpkqrqh6+fODKyuhs6kfgzBTT/a/4gk+yPz7x
         7SCthk4SE3/tatHioJRguOmC1cFc0HAu/ya5xJCMM4QuhogVEfzgUCRE2971Ve7CijgH
         Brn6BTs4Z/wq1XKZHpJASX1xNFUjodsGoYPDf2eaQXJUghlPbgOYpaXYQLq2hD3jZDdC
         pUMpQSBdZ3LgtLT0zPy4H5aXyMbe0gcQBRyoORVrPrbHueFuHBsXUDns2f+mk0aGJGAt
         zD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113752; x=1781718552;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46dTS54fJkFDX+n3fNAtP/BR3hdg+QzeIr8BMTbVi98=;
        b=VU7V3GKq/7RDPGMx+1UG2Bq5SVf896DlfWzrdGFCMjSway+pKZ94u/HFsmeziTmam9
         fhVPU8K3GmqHhhD/Tv0Cpl4P95sWs4h73+0c3zO6fswxj9bDC9MhN2s6UAwn82ob9Ybv
         dxaMPfTajEJfhXCe2YCDo2Mgbz5LnP89u9d2ayXwb6AIje4BN+h34Xn2tR25tJdlbGcU
         Z1c+DfVuUsQ14byfUk+TAXALJQyFJvjiWInzemA443YlLFb711tTFRrF9Wdr6wnsduVh
         w/G6JEGTiT5yAx7yuWwvU1sv5ipGo9eluoLpAqnewAMWW6Yol3Jmykxe06V81AiUgl9r
         EakQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2/JTcEV32+nmoRcnBPmkfEDtvHqbIz0KFPA85iGDkUT3PWX8IQEH+kcU+l3aSRpnqRFf4+fCauSV8XbNzjZQlSOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37ZHshU6BOq6jtVLqUAmC4J6DpHJl4oKDwo7s2zOBE763RhGZ
	GmTCF/t/i4O7S5hAE2+u5jWB9RkzrcikPFdmSE83rwKHkJRr2JwdsEbkjIQounlR6RoGCgUQmf3
	GlQ62JCd8VLvw67J/hRMxSJUWX+haGOmlQ4fg+Y5t
X-Gm-Gg: Acq92OF8b6uSaZu6BEP7nzaEb4BAYF6z3vnL3FcUBYYhFa3iiPryVvv1jWxYj+SS9Kc
	7wVUFCJLmpfUoJBt3VsF7dYjZ/b8v0wJH6IED8SHV87zPnRewi/SY5q0wZ2fNIACBpVllQin43r
	KQ9UwgIMmeyr52bGo5TBfmWIcgIAdMXYWmYdE6moiB1woHk0wj7cBuaZOdULbuTEFlmpZt15uGO
	Ulx3AKsNdLz89+N7pXYlugigIxPjVFuxqZKkaDHHV1T7o33oroCRX787Ph3TSQg9zWgS7owGF5t
	cnk23fWnVke+CeFAzgM1s4J0BwYYG/7riUNT61z4zpjI0p4PoxqkgCQzzVIgkP5h4COfYbrTgnb
	Xvrqs
X-Received: by 2002:a05:7022:6b8c:b0:12d:de3e:52c1 with SMTP id
 a92af1059eb24-13840b97c4dmr92377c88.37.1781113751391; Wed, 10 Jun 2026
 10:49:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 10:49:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 10:49:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiMVLtblIKu1DQWJ@google.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <CAEvNRgGpaggjd3=ooyzv7iEbmA-x1mWJHgjLSjPi8=5CPrk-yQ@mail.gmail.com>
 <aiHeDZEPkAcWcSkn@google.com> <CAEvNRgHz5GDjq0GqRmpQdHc-X45gCNr39VYWZH-T7XhPEtN5CQ@mail.gmail.com>
 <aiMVLtblIKu1DQWJ@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jun 2026 10:49:09 -0700
X-Gm-Features: AVVi8CeVNL_ZT6N2PrMDnjQ93ySm3TRS4viAqGi095JXk89KfuwRXMizMLlfDgE
Message-ID: <CAEvNRgF31BzyFyVUa7tDJ=qJ-8ws2kxfNjLxmV=OxKSqhaOiPw@mail.gmail.com>
Subject: Re: [PATCH v7 00/42] guest_memfd: In-place conversion support
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jun 04, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> >> + KVM: selftests: Test conversion with elevated page refcount
>> >>     + Askar pointed out that soon vmsplice may not pin pages. Should I
>> >>       pin pages through CONFIG_GUP_TEST like in [2]? I prefer not to
>> >>       take a dependency on CONFIG_GUP_TEST.
>> >
>> > I'm not exactly excited about taking a dependency on CONFIG_GUP_TEST either, but
>> > it probably is the least awful choice.  E.g. KVM also pins pages is certain flows,
>> > but we're _also_ actively working to remove the need to pin.
>> >
>> > Hmm, maybe IORING_REGISTER_PBUF_RING?  AFAICT, it's almost literally a "pin user
>> > memory" syscall.
>> >
>>
>> Hmm that takes a dependency on io_uring, which isn't always compiled
>> in. Between CONFIG_IO_URING and CONFIG_GUP_TEST, I'd rather
>> CONFIG_GUP_TEST.
>
> Or try both?  If it's not a ridiculous amount of work.

CONFIG_GUP_TEST was tried in [1]

[1] https://lore.kernel.org/all/baa8838f623102931e755cf34c86314b305af49c.1747264138.git.ackerleytng@google.com/

It looks like this

  static void pin_pages(void *vaddr, uint64_t size)
  {
  	const struct pin_longterm_test args = {
  		.addr = (uint64_t)vaddr,
  		.size = size,
  		.flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
  	};

  	gup_test_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
  	TEST_REQUIRE(gup_test_fd > 0);

  	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
  }

  static void unpin_pages(void)
  {
  	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
  }

So in the test I'll call pin_pages(), then try to convert, see that it
fails with EAGAIN and reports the expected error_offset, then I call
unpin_pages(), then I convert again and expect success.

Are you uncomfortable with the CONFIG_GUP_TEST interface? What would you
like me to try with CONFIG_IO_URING? I'm thinking that the main
difference between the two is just down to which non-default CONFIG
option we want to take for guest_memfd tests.
