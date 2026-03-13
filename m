Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA11373C04
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382397; cv=none; b=kFIsK3iwsuIaD+jOT2xpl9Ym+iluJlD5k1jkXomSUMv8yqglxvXIe6z49+L0aB/WcezqbDo1fMBTLHwYT3Ou4kSSQ5RT0ug/N9AiFMljbauiXzuWJL9UhD30EXF6mHlEffJ5eGhQnuceTEpl+69DY0+/fnmA1HaKGDKyrR668uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382397; c=relaxed/simple;
	bh=sxgVJ8rTnsDVVvkkCb/N/5psScG4ZKh4tfTvkLAGmSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvG0B0ym/zAYq3t5/dPY3UOwwspQBD9QovOPpfBZnqNdyRcxtW6F1IIXlx+hYMaSy9tSr5sFbUlXpTGUf01W2Thd5zGlJRfrqv8PbcIOU8D17jSXjk5P3k5vHw87ywYHIrhnFefUkLKotxgsRp/RRkjVUZb5lwB5Ic2SIlJiZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDEL/DeO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDEL/DeO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c738f71723aso1043007a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382395; x=1773987195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIA73EOEF8zfWIRjnNLmO0fDuVTBhQUnDUuak7WvzwY=;
        b=GDEL/DeOO6NCk0Uodeb5OJuRacXLG07pLtKZBXGZufV95LMk9GSfFgxh6O/BdY1gcs
         tY2zviB7vV7+NuuZulVTf63+Y+3vT8uT95NmuO51o9RO6WCOYV2Px5Mu2Bt/qxxb6+TM
         piov101iHHOSRr02lwxAKQAP3j9UNPqWWfLnPZDc9eJxi8OpT2GYqtwkD88wYaAcZaxN
         pvSqcGld38K3fOIgL/MBcVbXgKYpyukRHBUArE594QpJbvgVuzrbuZ7vrt5W/tzbKYez
         cysmEeFqd2i55BudFD56ntEQOJ26lJ1xWdSK3oyRl4xbL1Y2ElHV8vPENBwgULuYkyUz
         Cs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382395; x=1773987195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIA73EOEF8zfWIRjnNLmO0fDuVTBhQUnDUuak7WvzwY=;
        b=bB/SDsnKtxLDnQg3/uvbkqtl8HlJcM7+KoIsjBA0P+HmV8CukLKFZMxq7XVjuT/BvI
         aJjWrLD6cnaOLgXDA7OLwVV9b7U0iDNv6lTozAHebInh5G3/cpjZzlEHNzim0YDwaVWc
         zo4cMgLfu8ENndg8NGXgimnZz/RH7kcx07XNGk/B4LjvJ58OE4Puc1AfmqUZS+Ic1Xtj
         WItZ9AzyrsOVZ0ocoJ4AxaY4mbWW27cE7R9xmruhODBgnECP2YSrEIv9MLFd4GcKd2Zv
         iBdto+oQH1bhD+1GhAIhwkq8dqD9Ded3wL8xcH2F7LgwyygwbbHiHon7dsMo39k12InX
         9Vhw==
X-Forwarded-Encrypted: i=1; AJvYcCWWBynEvw4UlRv7FPZSrn9Ab6MpvAk3iblZsYhQZCsssHl/A3YrHZAJrQ7JigQfhb1fAdxwAG27Tdt0e2qGJY8P5Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6FQ3pagKjxYUzQJucy53cnlEivfzLLl5VqjhF5d+s/kIpnwLz
	rVzzoJSDJQtu9vLm3tTscNFAgiNzIHlyO5urrP/wxVAPUnwx6MAPnzjrbeFhB1XmFrwd1lxmV3c
	1BY/AA62UFYRwoGCvPMO6m8TH8A==
X-Received: from pfdj23.prod.google.com ([2002:a05:6a00:9517:b0:82a:ff5:27d9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:301c:b0:821:8ea4:480e with SMTP id d2e1a72fcca58-82a197046d3mr1745281b3a.10.1773382394655;
 Thu, 12 Mar 2026 23:13:14 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:55 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2423;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=P0HrtVxcvcqlWA/iAGoaJvXr6ZzCxwiLrVIFwieOOvo=; b=OFFegv3rd3IOZnzHW+6v/BpR4KTo/XpLg67/Eww9gNEmgAMLEZet90hrjrXlozg5YLYGSdcXE
 jyOPrYDtK26CFbb50GcRq6HOrH+9D2ETzJgeZNit2x7W2pBp7xYG0rw
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-16-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 16/43] KVM: selftests: Add selftests global for guest
 memory attributes capability
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Add a global variable, kvm_has_gmem_attributes, to make the result of
checking for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES available to all tests.

kvm_has_gmem_attributes is true if guest_memfd tracks memory attributes, as
opposed to VM-level tracking.

This global variable is synced to the guest for testing convenience, to
avoid introducing subtle bugs when host/guest state is desynced.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c      | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b4872ba8ed124..2871a42928471 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -113,6 +113,8 @@ struct guest_random_state {
 extern uint32_t guest_random_seed;
 extern struct guest_random_state guest_rng;
 
+extern bool kvm_has_gmem_attributes;
+
 struct guest_random_state new_guest_random_state(uint32_t seed);
 uint32_t guest_random_u32(struct guest_random_state *state);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 82d6945efa29a..404efb5318f09 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -24,6 +24,8 @@ uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 static uint32_t last_guest_seed;
 
+bool kvm_has_gmem_attributes;
+
 static size_t vcpu_mmap_sz(void);
 
 int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
@@ -521,6 +523,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	}
 	guest_rng = new_guest_random_state(guest_random_seed);
 	sync_global_to_guest(vm, guest_rng);
+	sync_global_to_guest(vm, kvm_has_gmem_attributes);
 
 	kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
 
@@ -2365,6 +2368,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	guest_random_seed = last_guest_seed = random();
 	pr_info("Random seed: 0x%x\n", guest_random_seed);
 
+	kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
 	kvm_selftest_arch_init();
 }
 

-- 
2.53.0.851.ga537e3e6e9-goog

