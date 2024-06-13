Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6071465BB;
	Thu, 13 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284882; cv=none; b=tJ31ZOSkIkdizCeTCwIw/MYuv5Xtvmmkpp9ynG9f0EuuYew4MNkzuSB0405A78dQbfD+V6PzBUJLDHjjpqIl2dpgeo2X7eTQJDKRdx7o5cN7NfThcMQe+sCHMx/lbpBxxnQwMvlVKL/bx2VWmvhoTH45Ocd18+bPUW0k/h93U6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284882; c=relaxed/simple;
	bh=EQ20HpMAIER6Uw/xHoQiBTRUedahaArff+OtmAqGPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBoVCk8xTYLxF9KEHTQ2r1mbWrLnPcaTpgScQmTHMtJPDlmPeAdrVnzSSHKzrj5bB1hTqKGPy6JH5egzZ2edTrU0jlxEXoy3d0BLnmkzMig7m//n0+uJ571KDO64406GzCOpeZHu/d1YcpPdqKhaXwEpkCwgX2shfDMelPSRwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5b-666af24d0095
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v5 8/8] Docs/.../mm/damon: add more damos actions
Date: Thu, 13 Jun 2024 22:20:55 +0900
Message-ID: <20240613132056.608-9-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnoa7vp6w0g7OPeCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M0x0vWAtOClQsmDqBrYHxJW8XIyeHhICJxPyGN4ww9sWv05lBbDYBNYkrLycx
	dTFycIgIWElM2xHbxcjFwSywgVli0rkXTCA1wgKOEqc3rGEFqWERUJWY+jkFJMwrYCqxtncV
	K8RITYnH23+yg9icAmYSj+a+YgOxhYBqZvy4ygxRLyhxcuYTFhCbWUBeonnrbGaQXRICr9kk
	3uw4BnWbpMTBFTdYJjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgTGwrPZP
	9A7GTxeCDzEKcDAq8fB6PMtKE2JNLCuuzD3EKMHBrCTCO2shUIg3JbGyKrUoP76oNCe1+BCj
	NAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOj0fam+8qzuFZNer+9bO/OFGn+hzb/9xvz
	iFUwsq24V7dSS9F6lfChXFnJeWmG9ftKnh2XKw49sSU74vQLXtd3PwP2uETmvq47oP/GztX0
	uVuvjtL11SoL6tRrc6ZsXXj48N0ayfebT212f384ViD54duccsmpX/cuiVUJmnMr+faDc6u8
	F175qcRSnJFoqMVcVJwIAAeMmpp9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNLT9fnU1aawdnV1hYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDJOd7xgLTgpULFg6gS2BsaXvF2MnBwSAiYS
	F79OZwax2QTUJK68nMTUxcjBISJgJTFtR2wXIxcHs8AGZolJ514wgdQICzhKnN6whhWkhkVA
	VWLq5xSQMK+AqcTa3lWsECM1JR5v/8kOYnMKmEk8mvuKDcQWAqqZ8eMqM0S9oMTJmU9YQGxm
	AXmJ5q2zmScw8sxCkpqFJLWAkWkVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYIgvq/0zcQfj
	l8vuhxgFOBiVeHg9nmWlCbEmlhVX5h5ilOBgVhLhnbUQKMSbklhZlVqUH19UmpNafIhRmoNF
	SZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cDIbDTHJ0jbZN9aqVmV3QyfpgS29XWfWWQzd0n5
	QR15v97A/FW/dL6GtW7WrKx44KSzRn7aqx4LoUfvL5//tet6zeETCyrTbkzImOj2ry88vV/4
	9eKTulN2fuLnOc27tkeyPq9Lxfh8EFfaasuPKle47/855DunbrHpjm98//ifHrzXHvxC//xn
	JZbijERDLeai4kQAaQY8EG0CAAA=
X-CFilter-Loop: Reflected

This patch adds damon description for "migrate_hot" and "migrate_cold"
actions for both usage and design documents as long as a new
"target_nid" knob to set the migration target node.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 +++++++-
 Documentation/mm/damon/design.rst            | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 7bff54963975..84d62d16c9f9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -300,6 +300,10 @@ from the file and their meaning are same to those of the list on
 The ``apply_interval_us`` file is for setting and getting the scheme's
 :ref:`apply_interval <damon_design_damos>` in microseconds.
 
+The ``target_nid`` file is for setting the migration target node, which is
+only meaningful when the ``action`` is either ``migrate_hot`` or
+``migrate_cold``.
+
 .. _sysfs_access_pattern:
 
 schemes/<N>/access_pattern/
@@ -759,7 +763,9 @@ list on :ref:`design doc <damon_design_damos_action>`.
  - 4: ``nohugepage``
  - 5: ``lru_prio``
  - 6: ``lru_deprio``
- - 7: ``stat``
+ - 7: ``migrate_hot``
+ - 8: ``migrate_cold``
+ - 9: ``stat``
 
 Quota
 ~~~~~
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 3df387249937..3f12c884eb3a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -325,6 +325,10 @@ that supports each action are as below.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
+ - ``migrate_hot``: Migrate the regions prioritizing warmer regions.
+   Supported by ``paddr`` operations set.
+ - ``migrate_cold``: Migrate the regions prioritizing colder regions.
+   Supported by ``paddr`` operations set.
  - ``stat``: Do nothing but count the statistics.
    Supported by all operations sets.
 
-- 
2.34.1

