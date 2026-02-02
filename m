Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CB394469
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071465; cv=none; b=JbFHVvenjoSx8NhQFqh8oixBXesrKklLRcsLH/2nX31Z0zGtK4xulYq0Ld3PDV2WWkzcvk9PcECXEo53ycoN6r2v5G8X1xYIpyGEYE+hnlOe4j/Z+CD70b0Fdql2O9UGiY6hFU5/kWeR/tyf+EMeRoe1NlrwPm/9ZFo+livzNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071465; c=relaxed/simple;
	bh=7xVQSfIkJ60fAi+bPq9Hli1XpdAW1vzJLCXGomttxF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+JG5W7D1GqzTWG0cdfWQg/ZayY9O4N+vY0bHh27VnsLqvjTmeAgp5iVAnuUj45cYwLQYMeWdgXrn7Ra/yUTIfVrjROaSI90mOr9fs4EJG6Xjzy6U8lQ/92I1NsZvlsZhJNIVGuWVglBPQlz0BIseNwz4OHgWrCKJIyyMuwNVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6i5r6zd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6i5r6zd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7b7f04a11so131999755ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071463; x=1770676263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLfu655wfwWblICrTnC7KQ8iLfPY+MU227oVBvDsC+k=;
        b=n6i5r6zdq60Uu020ecYrtTCvpGL4pLEc8df7vvTUsdpje2fcDvQ8BjUi2RHuCTx92d
         0ysjy1iAVpzXwxC2dspBDtgGhQ1REYoRXxFQ4W3MBI/y+9F0dj0bVf8MCeHiBUdhiV9o
         0XuDOxZx84OFxujz36kuXi3OabXNbuarpJhXZ3OrQNBLBOspC1TBUlV9vAO5mZrRanEx
         FjAJCgcT3Cs/ztoWjv+QVjLDo9p3G1BIkFBZqwwCNq5IhrLx32qJ7tCI6nUtRMFgDB/N
         s0E/JJ/+zbUN/5XNDb0AqtNF9wvTxILzCnjLeBT60P8lBceBG0//WuphvXpTKk28Iy3H
         q4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071463; x=1770676263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLfu655wfwWblICrTnC7KQ8iLfPY+MU227oVBvDsC+k=;
        b=aqlYYulgePTxeA8x00dB75AShm41m7jnr5wOsJPS8aDv/6mbvgP43n8WNcPysAkyqE
         2HsGy6oZJdQpUdIhMv+C7e8tMH8b9b6pOJDDW3ZmpC8aJjn7emGBTvdDpPOp3w5CZk15
         NAhQiNikvfjObYUZQ7BRos/PLnC0ZLgTl1Byb8EOiJ3EWvL+x99MQu9edIWwLAlinURn
         +/oQDjV7RfXLXWZqZs15zRCxtka5vVCHfGoiIPT6CJO7MIJPJ+40XSqQSFe9BIZzMMMz
         lYIGxg1KHVBRUPs/AW1qiBkUXsqQKEg2tPaWYGVSt7LSfBiyASTgyglnzDNDgxZ/mP+i
         Cslg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7Zv0oBDFYIossUmYyNh7DD8BkXTHjeQr7jWohn3mZOT8M36jdlaIOpI3KUWAa2oCJq2Ii/iUrAmVbeKxW2wmphk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Vy7v/7QYRG8SCJtd78wQqodFc36amyOTQ2pDvIwsqfoxaTCD
	tA4wWRGX78VUZ6uCB4iEAFTPvYYXppHSK694ZgPghzgdwWEuGxjFtzGOpZeE/w3nfoPoKauq7GX
	2ig5cdPWsdoNUnXCC4CgJlYavWg==
X-Received: from plau12.prod.google.com ([2002:a17:903:304c:b0:2a0:909e:4227])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f87:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a8d9a6f717mr139318655ad.52.1770071462970;
 Mon, 02 Feb 2026 14:31:02 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:03 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <527031abf315ca4c6eb42bd3c6618a884ea90d6c.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 25/37] KVM: selftests: Test precision of conversion
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Enhance the guest_memfd indexing selftest to also verify the precision of
memory conversions between private and shared.

The existing test converted a single page within a multi-page mapping but
did not explicitly check the state of the surrounding pages after the
conversion loop.

Add checks to confirm that converting a single page from shared to private
only affects the target page. Iterate through all other pages in the
guest_memfd region to ensure they remain in their original shared state,
thus verifying that the conversion operation is precise and does not have
unintended side effects.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c    | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 9dc47316112f..b109f078bc6b 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -227,7 +227,8 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
 
 /*
  * Test indexing of pages within guest_memfd, using test data that is a multiple
- * of page index.
+ * of page index.  Also test the precision of conversion, that it does not
+ * affect surrounding pages.
  */
 GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 {
@@ -247,12 +248,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 			test_shared(t, i, i * 2, i * 3, i * 4);
 	}
 
+	/* Confirm that only one page was converted */
 	for (i = 0; i < nr_pages; ++i) {
 		if (i == test_page)
-			test_convert_to_shared(t, i, i * 4, i * 5, i * 6);
+			test_private(t, i, i * 4, i * 6);
 		else
 			test_shared(t, i, i * 4, i * 5, i * 6);
 	}
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_shared(t, i, i * 6, i * 7, i * 8);
+		else
+			test_shared(t, i, i * 6, i * 7, i * 8);
+	}
 }
 
 /*
-- 
2.53.0.rc1.225.gd81095ad13-goog

