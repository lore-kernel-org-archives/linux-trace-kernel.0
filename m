Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEE3939B5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192796; cv=none; b=SdTnZct5aOfrfmbl3QyOmp4F2JScYh/4We5N0ed1eFpx2Ed7Bc61C35dDF4BAI9KR2upiyaPW98+qrF652+V6Xo/rrw6EJBSiVQw8up1DM3kizJnYDM04f+e+SHSkAoGJJBFekET9YsnLyOyq5ICc/fNPIJtDUI+YaQp16Qw5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192796; c=relaxed/simple;
	bh=rzzbz++k+Syo0+alvwR6Pj1Z4/WDKW3XNFj7YkGBOUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+wjpLSfvmoj3erFINrbD3NFfS+onPfNe+8HSutbHZFJnSiG82sg7Ep6TTQg1fWW4/Zmitfd4NvE+CwqckfhMhs+ZxbeyrVKn3POm2mUzmor1izWRAtVyKr27NlQeg7TnO76GZYzv5l9c/A9iQn3Tj+d8Gt9f0selDKUOlTUbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxrXnopI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxrXnopI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2d65d9792so10007245ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781192792; x=1781797592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkYI56ab44R+CGvXUlfI3ycHykGEF+9O0JMidioFwIA=;
        b=RxrXnopItWRUKFsvJuGu/1PEMqGZf8sHSY+ZZyZwYmXgTV2hEaRPyMGf1QLNH98tTn
         ZYN2GfMfyd+FplSUa48NpR+M0r95nKiCwss0a1QWG0TnLc5Hkahdz/jpnq6gUGPlIst/
         mRrH17zalUoIhQMLjzjmNUFzu7+K/Z5vdCLia5VjfqRvdZIvrotw+uixqgU0LR5mhZDR
         lRFGybBNnW/rVx1yreVWQpGtI51qBbKAucX4xruEyIQf35FHnJKScMLOySKw15xtZLk9
         gcwkrYUcQ/kGz6DlrSircsVUJE7fC7nLABOBPOa9dA4//CWR+bXiscN4mEF0V7UyrSNY
         TxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192792; x=1781797592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkYI56ab44R+CGvXUlfI3ycHykGEF+9O0JMidioFwIA=;
        b=ElUhxzXMXvXOcAPYhtFEaXASdYUg2PlcmuL8yonB3iReRMK5JVaTAdGz0f+JrzXVJM
         FiHB1WcDYjTm3KLcIEApEKG1sLe8R0TRRCgRjQtPm1oK6N3Z+xR4ElNjdJYorI57FDbr
         2B6xkukuVwPE6DW/u4sr9Z7pekw4ic/lE0H+4iQq0qYf/U6avd8/e+Meohu1XlR7zOAq
         +adhmj4lVYuEHXfXZU8h8gex29v2UAMFSV3sX71bcHWGoLFrihiKCe/u+sjj51oV5trB
         TE5MtbfF4swPW0b5paAchIJC77ILB2yO9l8LXX4dOwrIOHE1/5KbLZRjQ1gHfU0hZUX2
         dfgA==
X-Forwarded-Encrypted: i=1; AFNElJ9VE5xCmCKsKH32mfda89SRUPmy6Y16yq/CfumSDaV+/9E/oqlywgaqquZ4FTm89GPLWB7EOws97B+LDMzYquX7+UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuht2oDmJU32h7yP8UtH7wJ1Oka+CzSRiBDVt1IjX1EPW4YZ6K
	wM2Lyp4YsfaHmDJJjaXHAG4oH8Oj5r3cLYK7W0A5Yinp5gMWPoKjId9WfMEpCSUHsgqnwDYTOLH
	uFrWznA==
X-Received: from plbbb1.prod.google.com ([2002:a17:902:bc81:b0:2bf:17b5:30c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:947:b0:2c2:245a:3366
 with SMTP id d9443c01a7336-2c2f305aff9mr45838065ad.27.1781192791738; Thu, 11
 Jun 2026 08:46:31 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:46:31 -0700
In-Reply-To: <CAEvNRgF31BzyFyVUa7tDJ=qJ-8ws2kxfNjLxmV=OxKSqhaOiPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <CAEvNRgGpaggjd3=ooyzv7iEbmA-x1mWJHgjLSjPi8=5CPrk-yQ@mail.gmail.com>
 <aiHeDZEPkAcWcSkn@google.com> <CAEvNRgHz5GDjq0GqRmpQdHc-X45gCNr39VYWZH-T7XhPEtN5CQ@mail.gmail.com>
 <aiMVLtblIKu1DQWJ@google.com> <CAEvNRgF31BzyFyVUa7tDJ=qJ-8ws2kxfNjLxmV=OxKSqhaOiPw@mail.gmail.com>
Message-ID: <airYV9lcIM4xdA60@google.com>
Subject: Re: [PATCH v7 00/42] guest_memfd: In-place conversion support
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Jun 04, 2026, Ackerley Tng wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >> >> + KVM: selftests: Test conversion with elevated page refcount
> >> >>     + Askar pointed out that soon vmsplice may not pin pages. Should I
> >> >>       pin pages through CONFIG_GUP_TEST like in [2]? I prefer not to
> >> >>       take a dependency on CONFIG_GUP_TEST.
> >> >
> >> > I'm not exactly excited about taking a dependency on CONFIG_GUP_TEST either, but
> >> > it probably is the least awful choice.  E.g. KVM also pins pages is certain flows,
> >> > but we're _also_ actively working to remove the need to pin.
> >> >
> >> > Hmm, maybe IORING_REGISTER_PBUF_RING?  AFAICT, it's almost literally a "pin user
> >> > memory" syscall.
> >> >
> >>
> >> Hmm that takes a dependency on io_uring, which isn't always compiled
> >> in. Between CONFIG_IO_URING and CONFIG_GUP_TEST, I'd rather
> >> CONFIG_GUP_TEST.
> >
> > Or try both?  If it's not a ridiculous amount of work.
> 
> CONFIG_GUP_TEST was tried in [1]
> 
> [1] https://lore.kernel.org/all/baa8838f623102931e755cf34c86314b305af49c.1747264138.git.ackerleytng@google.com/
> 
> It looks like this
> 
>   static void pin_pages(void *vaddr, uint64_t size)
>   {
>   	const struct pin_longterm_test args = {
>   		.addr = (uint64_t)vaddr,
>   		.size = size,
>   		.flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
>   	};
> 
>   	gup_test_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
>   	TEST_REQUIRE(gup_test_fd > 0);

Use __open_path_or_exit().  I also think it makes sent to make these available
to all KVM selftests, there are probably other testcases that could utilize page
pinning.

>   	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
>   }
> 
>   static void unpin_pages(void)
>   {
>   	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
>   }
> 
> So in the test I'll call pin_pages(), then try to convert, see that it
> fails with EAGAIN and reports the expected error_offset, then I call
> unpin_pages(), then I convert again and expect success.
> 
> Are you uncomfortable with the CONFIG_GUP_TEST interface?

No, my concern is/was the potential for leaking pages if the test fails/crashes,
but it looks gup_test_release() ensures all pins are dropped when the file is
released, so that should be a non-issue.

> What would you like me to try with CONFIG_IO_URING? I'm thinking that the
> main difference between the two is just down to which non-default CONFIG
> option we want to take for guest_memfd tests.
