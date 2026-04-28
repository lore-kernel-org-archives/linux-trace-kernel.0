Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEF3D905F;
	Tue, 28 Apr 2026 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418721; cv=none; b=JLk92IkbbY0Ok73BvrD9ipk8AAbLwjHnOjWxz/aWDUEjKkXclgharoC3GkNmSUXWR3APgcM0rL0FRGVsuHA94OYNe9qaOLHEGRCoUkWi45qXMvy/ZMPwq+KRLZjls5JHuV4nWfQg6WY2VkItKPm35HGqmTKq7DZY2yr4vIIHeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418721; c=relaxed/simple;
	bh=SAmPYY8ikK4ezlQwpFa0qJSjGj7Hehm7adP1PCdg64M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IosZk5zxfU2ikZ/01CmSnOSMIWU4xJ7+RfTH9n5DnjcpJUxCCozu7adaMVmzM9sSbqRgsdk8j5YVxvd6LBP9TFeCsHjkZy+XoVMRnqkZ2ktzmzRu1+KU+lsTqBPB5Koh2W4NUMDNCwc2h9C4aTbvEOtty8pKlLNkkF/2kajv1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbiu4tt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbiu4tt9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 538FFC2BCB8;
	Tue, 28 Apr 2026 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418721;
	bh=SAmPYY8ikK4ezlQwpFa0qJSjGj7Hehm7adP1PCdg64M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sbiu4tt9r3333B2m0VI4lNS1EPVTgi1gSvQG257nZ0yeOBC04OLCI7S8P1OKje+KO
	 OOI8LK2gNImg+0V2pPVZsRqr614T7l8D64kUrbZ164sgfOCdjhdLJdzlLJ0zhlfgLt
	 L9+yfg86gwoyUrUXj+spY2zQNgjD7y7+IVm5gfJ7vKOpnO+Fx4m7wJzln6xfV81pd7
	 ff7ZZczkzB45dnDbShWr28sTNyJtDAwBxaOfswmWlD+0lWWgY/nY5ya9rokXj5AEle
	 zR34Acdgw1V7LCYve3zsXffG+mqNYAVkUWoxQ1W/7GEZzluPLgfAYuWMuajrl6Ehnw
	 yVraDDJW9ePEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA54FF8877;
	Tue, 28 Apr 2026 23:25:21 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Apr 2026 16:25:43 -0700
Subject: [PATCH RFC v5 48/53] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-gmem-inplace-conversion-v5-48-d8608ccfca22@google.com>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
In-Reply-To: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777418714; l=1296;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=IxI4eTFElDaAEgNuCkIQkVDl6ebpJJNnDFRZJGqwXQw=;
 b=WwmI5IeOHhkqMGZ/qG56oUC8AyqB97cuGsLr6zsOzEnvokGwUPESMchcaDt2kB3vL7wLTuZ9f
 DlnHwXKVjgEANKol0SPOqnV8OKYSDjJDIZc+57uveI/Ja+R6yt668Wm
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Sean Christopherson <seanjc@google.com>

Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.

With an invalid fd (usually used for anonymous mappings), there are no
constraints on mmap() flags.

Add this check to make sure that when a guest_memfd is used as region->fd,
the flag provided to mmap() will include MAP_SHARED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rephrase assertion message.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 12e031a8fc20d..29b3f4e9fb4a7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1088,6 +1088,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 	}
 
+	TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
+		    "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
+
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					vm_mem_backing_src_alias(src_type)->flag,
 					region->fd, mmap_offset);

-- 
2.54.0.545.g6539524ca2-goog


