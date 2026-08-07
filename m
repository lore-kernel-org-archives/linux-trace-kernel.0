Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E447F2FA;
	Fri,  7 Aug 2026 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139571; cv=none; b=NneSF3eckyOaUwcczkzwysjptAn+i2AEkAUuG6K56EhD24590eaNfZUmhxI92PphIKaH+E07luoJu0rZ4HSw54A5OAwA5+e4dVNnaOOqyaFuSmN1VynjdiwO92M26+NXSHJvkgtJ/Nf4S/PLBbmVi466DFIlT6roaIV0qQFNPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139571; c=relaxed/simple;
	bh=qqzdiyNUgHYhFJAhz2OLTx3xm0dCCGWmIe3EV7o9RvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKgq4WdyHZ9zU9FQFY5dpVeGnN4d9NSYbgyBPuVhGexi8KDgz1jxIEuxeQdX8b3REnsmfYu2Ape2fK3JeNke3DPqz4rtbOisL4msO68tgMBVGiqLGbsctXUEafXxYhCgEx28vTQVtK+F7oNkUBhaRsvj4LmyaNEueJogSvO8BLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJDA5EKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJDA5EKz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52C96C4AF52;
	Fri,  7 Aug 2026 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786139571;
	bh=qqzdiyNUgHYhFJAhz2OLTx3xm0dCCGWmIe3EV7o9RvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JJDA5EKzDkEVpIFwaqK+GBznZFtMm+NkAQXGGtzqoZ9e8nAndBIZqjUdDpjn/QQtB
	 B0fcTB/uztCdVzuyQCx4ZaFN4TvLTLfgq1Cy8zkcK0pLrWhdftqxRsuc1po5TkqPpY
	 jIVFa/lPH7Y0Zx4gu0wlcqqyEayvVCz3vh6+rBzTipL33RXO9HgkDhL2LV4l6Mb0fH
	 xPiDRJA4Rk0JgG/6j0hQiXVPoigp9HqAcoa3rJzl3pEFGVLVGAnyfyC4b3xOAuOWV4
	 NJ2jnUU7HPoiHw40omUiDenTp6D2QyMHVhL1UjvNofTSxCWOf8uLSNW7jwlL0TQnh1
	 hM4P66OZT+IIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308BDC5AD44;
	Fri,  7 Aug 2026 21:52:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 07 Aug 2026 14:53:15 -0700
Subject: [PATCH v10 36/41] KVM: selftests: Reset shared memory after
 hole-punching
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-gmem-inplace-conversion-v10-36-2fc18ee6d3ba@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, tabba@google.com, willy@infradead.org, 
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786139565; l=2579;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=8D4fZWoQ61fs10P4wW1NWAab+kfHlzlVCGaPrK13txo=;
 b=SszwThQ1P/kLbfeBg41IjKPAR4N6GnShBqcO1dZvZxJT+Hz6+KdLfcFuRLAhHEL8ubXBszGre
 tfZdFUYbGbtByPo9jXn86svXQxTJzOB0LlrhT+0Wrj+3oj+THtZz1/L
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

private_mem_conversions_test used to reset the shared memory that was used
for the test to an initial pattern at the end of each test iteration. Then,
it would punch out the pages, which would zero memory.

Without in-place conversion, the resetting would write shared memory, and
hole-punching will zero private memory, hence resetting the test to the
state at the beginning of the for loop.

With in-place conversion, resetting writes memory as shared, and
hole-punching zeroes the same physical memory, hence undoing the reset
done before the hole punch.

Move the resetting after the hole-punching, and reset the entire
PER_CPU_DATA_SIZE instead of just the tested range.

With in-place conversion, this zeroes and then resets the same physical
memory. Without in-place conversion, the private memory is zeroed, and the
shared memory is reset to init_p.

This is sufficient since at each test stage, the memory is assumed to start
as shared, and private memory is always assumed to start zeroed. Conversion
zeroes memory, so the future test stages will work as expected.

Fixes: 43f623f350ce1 ("KVM: selftests: Add x86-only selftest for private memory conversions")
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/private_mem_conversions_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index f3de2a4ab0551..cf50e9a332c5b 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -202,15 +202,18 @@ static void guest_test_explicit_conversion(u64 base_gpa, bool do_fallocate)
 		guest_sync_shared(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
-		/* Reset the shared memory back to the initial pattern. */
-		memset((void *)gpa, init_p, size);
-
 		/*
 		 * Free (via PUNCH_HOLE) *all* private memory so that the next
 		 * iteration starts from a clean slate, e.g. with respect to
 		 * whether or not there are pages/folios in guest_mem.
 		 */
 		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+
+		/*
+		 * Hole-punching above zeroed private memory. Reset shared
+		 * memory in preparation for the next GUEST_STAGE.
+		 */
+		memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
 	}
 }
 

-- 
2.55.0.654.g21b8a5bc05-goog


