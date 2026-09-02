Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC454A499C;
	Wed,  2 Sep 2026 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361912; cv=none; b=kmkhNvezY+qK99mBRKooX5IOIwMhckBETbj1WlguP5CBZFw7EamffUAy/U+YbijhXwKHCAWgttK7wGx+B/8Ld88n0FeljM6x+Jh6gSeG3uWs0Tm85Z5MKAG95G4uXmuYVZmArhwQUzehR+akzNThP0e6nDLdWGDGHVFjbBFOmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361912; c=relaxed/simple;
	bh=ibr/j2gpobjRQbUD99yRSw2v85e/E3NAoGIW7RNmVyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLZsRJLkAzumj2uZqSQxWbkPWipA8rJsoC30i2gOUuvW4YMvhwE1b1ec7I8UVMx9+1FGrcKOM8m20l3/OpVBWx37bMy09lTF48EJ8FRRyhczuzcH0r96QYMsdJ5SHvt8ymktAgVc7ETmlAJ9tTSFk9Yw4JD4YD1o/9y4jNwDhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=W0XbqfPV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aPsZeRXA; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W0XbqfPV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aPsZeRXA"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZmR64J8TzMlCH;
	Wed, 02 Sep 2026 17:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788361906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aNgEJx62+KEZOmgroOUI48+z30y8hztgfacUD+uqH7c=;
	b=W0XbqfPVhlXJw9H/wb1v26+1LkpgBy11XR5DpV+Scyc1zPuoEm4j37obzeKvMllIHOayBa
	30MOAsI+whQayy8VsCP//hfAEQDitYfGr+nMRVIBvOVJGPQ/3dS943e+LpZRs8hrtrtRrP
	T6RoU3JhfGh32mKfoNXYwy08eSdnap2sXVSAN3ACAzNc5d43hweTj+Mum18uBVN/VZSg+s
	28nmNshSQIwONfVMlx/7KYHIi12CTaUelCm+1MMm4Op8VmvgHn43/wepQbF6kHAntJOURx
	JiQTCdS2lKKD7P5YVuz1wQJBK8FfU6e5ki+FZqMYkVZs6LCu+dM5W2p1975dDA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788361905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aNgEJx62+KEZOmgroOUI48+z30y8hztgfacUD+uqH7c=;
	b=aPsZeRXAto/1Hi9ZBNqzziK7/FYpNAGM99vVf6/b/2GdeVVXLMtkFy0yBcPxLHI35kSxq2
	DUYvISOHyEGUVHDuckumZj27YlsANuATh5EmevLWqSteB9gVMuNeKpdXs6ZlBI8mnapDvE
	QUkKD4P1ImGM7eGZ9zl6GlgO7wsbfGP6wKwy3+qhHPjS9RpXnGwf8i8rXh21Prl987R2d8
	5EXCNEz99QIKqhcsIAiN77O0rhSXosqaoGde9bOzkVyZO6IegexOHIUh5q1ikO/KDvUijb
	pZPP6VudTH5MoawbuvJP4HRP5Zub3LqkvOAorf4MHen6evwlKFlTp/mkAMHHQQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: trace: histogram-design: fix bracket
Date: Wed,  2 Sep 2026 17:10:31 +0200
Message-ID: <20260902151032.706407-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e72e2b03c3e05f244d4
X-MBO-RS-META: t9wtxtaoe499fbwss8w6pdyf1uxrxq1f

Remove needless ')' from sentence.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/trace/histogram-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 41a726cd3..b757afa22 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -876,7 +876,7 @@ next_pid field on this sched_switch event, we retrieve the
 variables specified in the wakeup_latency() trace action, and use
 them to generate a new wakeup_latency event into the trace stream.
 
-Note that the way the trace handlers such as wakeup_latency() (which
+Note that the way the trace handlers such as wakeup_latency() which
 could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
 are implemented, the parameters specified to the trace handler must be
 variables.  In this case, $wakeup_lat is obviously a variable, but
-- 
2.54.0

