Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E603395259
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563909; cv=none; b=ng36yVpeOw5RAojmOsSIihB1O8UpymriNm+GAORqkcMUzKewCHa1vSNtqA0sSae6E1LmhtJy37vpEWe2ezUItFyADluenL+ubDAGy2819zok0CHET/TIT+qQ0LYwesWaG5qEMBcoqrGCidEqEJFJtGneCQBK4SXiH1aZPr3/WbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563909; c=relaxed/simple;
	bh=Xyl14WuQ359smVDmZU9FmOAAAQ4mehFnzmF6UoKVLNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hWnD1g0kpSeRMTW+ISjRktucrFoAaAPZGVqagBPuOPY120+VlKacDHVCIK2kNLY5nKca1Q10VuZHj7gSx79vdwklGA/+U0VqQeArb+o72orR5GBkRB0TsNe9aWIWzs6w2uJyV18RXLMpjBznWzmVEAZ9lrFa8+Q/hIk+v+oZ5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cvpjw1YZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cvpjw1YZ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so1962967a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563908; x=1775168708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owzrYdfkye/YERaKc5lVrVSnV0ZRCiFrjdhCMOA3vqA=;
        b=Cvpjw1YZl9AERnW441AjE0+DXH85VfDZrcb+iQYGzFXzmC5qXe5TCuvyUTuetc8nSv
         o/7SQXPm0qzNfCAGuTInyPNa93GUU6RuZ9bENo5AvgX5/RIK5OGoL1Jy+ELTF3UZ0V97
         mYjYXyj/hQ+jGG85weSv395Xjn3+NqCVINldAxldadk07XAae8MqAMsW36ByLe4pPlIk
         lBxXhQZouXul8cE9zmrVbZ9KjlyzgrCunsct35S490gex6IofDmuUwhkDnfStrLLAUHc
         jpYkPnV6nwaZmiF1vebbYfkZcwVU98X3+WhMdfStJoZPRKVAQC+ffHdFA58S2I5n1Sbb
         E6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563908; x=1775168708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owzrYdfkye/YERaKc5lVrVSnV0ZRCiFrjdhCMOA3vqA=;
        b=ZUYsgh+vg1kCMUzPA6EVRYiHDwNvqpP7tk6nGigd/CyKEndICurti/0TrpRadRN3LN
         7uJ2b6FqiI3Dn8ziDZqnLrjIUaXlZkpa3mgxr7IZGLdEFgkNfR3sVDhIohRvZQc4NLHq
         Qi0oLON7z865yY+cTqz06xDuMIj6Tlm2iMXA705ObdR/bd6cpOZDu+VoFrQ662TydRsm
         qgO9f6KwkHRgDeC6ALBp6DPYSWHHmTEBu4WhBB05hvSaYFIZShNdwKPrS+r7J/JbMuCD
         0VKyEdqAwNlcOVZHPEWd7DKOUVYjtnVQStaimVd6Aqyomcjy0rm1NKk90IwuwWzwFJUd
         xcwg==
X-Forwarded-Encrypted: i=1; AJvYcCV9/yNpbsSDEI3E0BRaLoFbnJJAfjLlhbC3ntTv9wqL8n+vsIHOAZNxmrOrBv0LoQf3NkbtKHveZdbFzyA2wN/2KiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxPiNFi8KGu1AUdgDSx79gO8jegwgN/tOWOjMwfPTBacXgU52
	oQySjNfIjXyjSK4YVpp9L9A2VxU/QnllU+LCtXWs2DL1khxcLeh5tmNZ7lfHE79gpyw9kZiohC1
	mACMs/W2gKtpUVlYamweoAJ9ueQ==
X-Received: from pjbil12.prod.google.com ([2002:a17:90b:164c:b0:35b:9d0e:7821])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17cd:b0:35b:e594:503a with SMTP id 98e67ed59e1d1-35c2ffd0ebbmr200447a91.9.1774563907528;
 Thu, 26 Mar 2026 15:25:07 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:30 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2424;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=SPrXtBzhAZ8kM/S0wIFvUys1KOsEIn60uKsPIVirly4=; b=Pb2Ke7FYWhiSBLICKGMsXf4XmOQ7g9IKaopuyp04/7PZlASOeNyYFutPu026ZSgYzfo3iSfAk
 84jt/X+M0iCCjjNze4tzM8Q5uhhhTW0IjXQ1s4Nh16h/Gz+oHiW+LZG
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-21-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 21/44] KVM: selftests: Add selftests global for guest
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
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
2.53.0.1018.g2bb0e51243-goog

