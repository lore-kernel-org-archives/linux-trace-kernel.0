Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE959472523
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194166; cv=none; b=SD9Gl5wYFFOmhLSUBZR152vbjTVqJeJwd7YDpxT5sSv2IwH5lBY/YsNSytC5aE0+7do+ZwwspTK0WS0FwNi1toanLx9L+1W0JYtOegsOn8FdV69lW4PRe7hxS56QHSAPJydhRzM5Qyluv7ejUVSFhztNIuRx+A+AVpwZ/wT33AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194166; c=relaxed/simple;
	bh=W+faagf9X6giuP7Jvxi6Qt0uOgcW4oIP8+vZrnvBrKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlJR4RkyebNEZj4cmc24qQuKoRlKQEc0EclMsWd0OngQMru+OPQQjxJmM+HivIyadlxbWZ9k0wCT+IBWvwRV0126gKBSny7B9Q7pyztw4dk6m+pzfB37j0Sn/ZATiM7Psr6Efccfg7GJVnF1jACpkS9UpJd934qybho3JAu1AcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjRKQpXG; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjRKQpXG"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so266546766b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Oct 2026 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791194158; x=1791798958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD6pTqRDMSfKXNqb4UUFNdsEKglv/1NbFFOX0KLFSbY=;
        b=pjRKQpXGy5pKioKH0vNhIv+OzeJ169eVsG2YNcgiBqiC3xEo+FE96ZcRqUQGXLFD0A
         Gpq2B7up3uzdwtfNNAQ7AxB2S25+Y7qqHbJyjIWzfU8YHzEFLid16rM1u3aTS1EZiL01
         JWvnjTMENNsYPBHXJiJ/ArMykcwISnnAEScTUE8Zo6a0U4k1fl2AzYk9CQVWhL0BEg//
         PY9Thc3Ythz2pNIV+iMx/6IA1rAYkTgkkMJyoKvaqfzHFFo12DtI/xhxPuU1RZi7wMBU
         demZjUTzkteY6DVzQCyEEioCZFfjfmeuWlYueRqq7i5Grg4C93NfCE6anodu2kIGEN1H
         qefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194158; x=1791798958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD6pTqRDMSfKXNqb4UUFNdsEKglv/1NbFFOX0KLFSbY=;
        b=CtukUci098DNnL6kzeoQxwoeXYZG6vBqiMPCfFKUlfk+IOj/CLCArjA/EE5B0UnM+V
         +5FMOgv8AuBUf3OwBnlMfaXA5tGA1Xl/cCu974dsFLYYoUCPhHORntZwkq1qBGvvJ/Pm
         UpSElGtAb+6qh7+qJ4bsuhQCHadszGAmtQ/ZuBhrJP+LrlzBFKi01pymPyHT5FfRgjXT
         zh0On9oHq2yWlLjkMZqJvZ8jHbcVrQIbAprunHqVrCeYc18wCZnbjwcO8PUDJa6+ye3I
         3Zu7RDQ7CXmhvbZ2Cv1Ec02TFq8KdE3FlIslOzeJq9camyC/ok5JC3ZbDAmWiyfHOLgw
         z7+A==
X-Forwarded-Encrypted: i=1; AKwUvBwLXpTJjprzwNm8VOD7eGy1xUKw8nkuDwvRbRtO39h1P7dpOhszS4Ldm0vJkQoxdbgdJcR00eUpVVABhwhZGZEqlZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJccYmT3q7CGbxvLJ2EpZFezXqMv1r48fEzGG0bjLtrP4RkkKxH
	jy3D3XhFEWks/GnAL9EclmBL+rSpB/rgvYWZj5YH/50Hgv5A9XCMrvbl
X-Gm-Gg: AYBFou2i8md5qhRKaHcGhNBtONGL+03GGPKqUi7RkeyYLJCtA8gmxg1lrKG4COW+vkT
	KRZBVEXahKtlweJTRw7pB8ULckuKfb64F36AkBIHNKvbpqkbYuRV0pn2yzY/0kLElcSc6YD3a20
	Yol2gBUP0bBdoJQPtLk3xx0oPN2EVMcVv4GZSZQ03I2Ptl9FJWDcIwKWMXZqtz2ulvwnCS09ppB
	cZEfAzbR01WzJj2JwRLoTuMXik5Y4/iQxE5rrxyqqkWqwrGmSQFO0SDOAUKQ7921K4ol2pDaCYs
	KRk0pWMFp++TynBq9cDtapCNvb73CtuxjnvCtqA7BNJs3XyMJwqaaf5npV9YO6LjRYwtd0oyBc4
	OFLXAbCj+9DRVrtd8z+2IPhKDtYJvLQIATE5H3f8R62TPQDn+x/SFRa79QY/T/gRXBu2GorC/Hh
	lQ6PuHJ4iVf94+UHRMAkTx6iimioXs3DtK8Cd9fQI9LT6WsY8o4XCdg1qAFcJR3I2uvRkrR8PT6
	gkudfaL5lwkmJimTwNcLGkCX2FrOEuMcjVFsNtX9F2mQcLw421tS2l74OpnAPhBdI2m2n+EzO30
	I2BhrN8iOK/PObCiDUaBHv7ireTVkoInf7M=
X-Received: by 2002:a17:907:3da3:b0:c2e:7fe7:288e with SMTP id a640c23a62f3a-c2e7fe736eamr411177566b.32.1791194158114;
        Mon, 05 Oct 2026 02:55:58 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31562aba16sm50753266b.23.2026.10.05.02.55.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:55:57 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 3/6] dma-buf: Add ranged mapping invalidation
Date: Mon,  5 Oct 2026 09:55:49 +0000
Message-ID: <20261005095552.52748-4-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095552.52748-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <20261005095552.52748-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

dma_buf_invalidate_mappings() tells every importer that the whole
buffer changed. An exporter that changes one part of its memory cannot
say which bytes changed, so importers throw away mappings that are
still valid.

Add an exporter helper that invalidates a byte range, and an importer
callback that receives it. The callback means that the address, the
attributes or the backing of the range changed. If part of the range is
no longer backed, get_phys() returns -ENOENT for it. Importers must stop
using their old answer before the callback returns. Importers that do
not implement the callback still receive a whole-buffer invalidation.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/dma-buf/dma-buf.c | 30 ++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 66b85d53ed22..e7010163eb2f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1389,6 +1389,36 @@ void dma_buf_invalidate_mappings(struct dma_buf *dmabuf)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_invalidate_mappings, "DMA_BUF");
 
+/**
+ * dma_buf_invalidate_mappings_range - notify attachments that a range changed
+ * @dmabuf: buffer whose layout changed
+ * @offset: first changed byte
+ * @length: number of changed bytes
+ *
+ * Importers with a ranged callback stop using their old mappings of the range
+ * before returning. Other importers receive the existing whole-buffer
+ * callback, which is correct but coarser. The reservation lock must be held.
+ */
+void dma_buf_invalidate_mappings_range(struct dma_buf *dmabuf,
+				       unsigned long offset,
+				       unsigned long length)
+{
+	struct dma_buf_attachment *attach;
+
+	dma_resv_assert_held(dmabuf->resv);
+	list_for_each_entry(attach, &dmabuf->attachments, node) {
+		const struct dma_buf_attach_ops *ops = attach->importer_ops;
+
+		if (!ops)
+			continue;
+		if (ops->invalidate_mappings_range)
+			ops->invalidate_mappings_range(attach, offset, length);
+		else if (ops->invalidate_mappings)
+			ops->invalidate_mappings(attach);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_invalidate_mappings_range, "DMA_BUF");
+
 /**
  * dma_buf_get_phys - describe the run that starts at an offset
  * @attach: attachment to query
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index b223962e20c2..55c3fe60a0ba 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -485,6 +485,19 @@ struct dma_buf_attach_ops {
 	 * required behavior.
 	 */
 	void (*invalidate_mappings)(struct dma_buf_attachment *attach);
+
+	/**
+	 * @invalidate_mappings_range: [optional] a byte range changed
+	 *
+	 * The exporter changed the address, attributes or backing of
+	 * [@offset, @offset + @length). The importer must stop using its old
+	 * answer for that range before returning.
+	 * Importers without this callback receive @invalidate_mappings for
+	 * the whole buffer instead.
+	 */
+	void (*invalidate_mappings_range)(struct dma_buf_attachment *attach,
+					  unsigned long offset,
+					  unsigned long length);
 };
 
 /**
@@ -600,6 +613,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
 void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
+void dma_buf_invalidate_mappings_range(struct dma_buf *dma_buf,
+				       unsigned long offset,
+				       unsigned long length);
 bool dma_buf_attach_revocable(struct dma_buf_attachment *attach);
 /* bits 0-7: memory type (a value, not flags) */
 #define DMA_BUF_PHYS_ATTR_TYPE_MASK	GENMASK(7, 0)
-- 
2.47.3

