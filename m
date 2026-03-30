Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76D362151;
	Mon, 30 Mar 2026 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852177; cv=none; b=KZpytab7UZGidoXYNcmBnif4kv3LuTcB/tqbnHOc/n+rMZbp0rHZaI614Ivqrey4bu94w1Dai+Bx54l1IjZQos50LTDVdxkdYgZ3ncapk5DGHybs51BrPTHk/BIMRafadK6zlCAPNn88XXvrICtUN2wWWn/gcXVRJczp3jkBOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852177; c=relaxed/simple;
	bh=JcDl6gOR/UKhs4PtWwUnbjshs6hcVcyPnzft3NLsHq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUcYGwd7sd0o44lRfCfFV5+4/2B8dFTuV0dEO0DItGj4rmfL985L424kBz35qFr2b00TLWL7hJQejHe65wKsAqsn4vfg4oB2iYw7r9L0uRqc+36EWAe6rhM+cTtqVEA+PNul/L31wzqzl5rk5lyxGWO0/Y8OqY0kXzlYX6JESYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowACnNgpAGMppJYTpCw--.61323S2;
	Mon, 30 Mar 2026 14:29:20 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 1/4] tracing/probe: reject empty immediate strings
Date: Mon, 30 Mar 2026 14:29:20 +0800
Message-ID: <20260330062920.40766-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnNgpAGMppJYTpCw--.61323S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryUuFy7KrWkJF1xXrWxXrb_yoWDtFcEvw
	1kKFs5Xw48GrnF9w1fJ3yrZr4qya1UWF1j93Wqy3y5J34UZrn8JFnYkwnxtryUWrWvgr9x
	Zr909r1ruF1fAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

parse_probe_arg() treats an argument starting with \\" as an
immediate string and passes arg + 2 to __parse_imm_string(). If the
argument contains only the opener, __parse_imm_string() computes
strlen(str) as 0 and then dereferences str[len - 1], reading one byte
before the string.

Reject empty immediate-string bodies before checking the closing quote.

Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0a5dc86c07e..e1c73065dae5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1068,7 +1068,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 {
 	size_t len = strlen(str);
 
-	if (str[len - 1] != '"') {
+	if (!len || str[len - 1] != '"') {
 		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
 		return -EINVAL;
 	}
-- 
2.50.1 (Apple Git-155)

