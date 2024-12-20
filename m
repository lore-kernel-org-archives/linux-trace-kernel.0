Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0425B228CB7;
	Fri, 20 Dec 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716870; cv=none; b=o3bAECc8tp2WUUu29W9LawvTb/BELHCiCLbAQlKHGroqfMauCrNPWHUKYKmVHKUUCOEt/ZWShGQENjaDkiFc6aCGhqYyuJRN6WCJiC0SFrbQkA4oN1jULSvLIv5O5XMBRKCzzrdbYBv90wzNHNY6VYe7ywmH/1y4JIA4YFVhV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716870; c=relaxed/simple;
	bh=3UnPfdticdpfn4zOxUtBMTJfpAGccJ0U76N0KLoCaRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbRXnaF6Pz2KipMtnu8cExT0c0Cox3J7Nh0N6v9ZDpcwsJgfiIrWriUIMK+7+qX4kSQAsdb0zmiCergyT47tppi1CMvuZdZ8zZkDo7tFqdPzacDPGkghy5siOn5U1lMOK0UETxO2GXuEJEcO9wZqNNkFSml3TYj+SAHDYOlnYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ykdfWEq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANWS8DVa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ykdfWEq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANWS8DVa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydVul0a4FP+4PcNCblFv1cuoHBvYBqlDRcudAEX3HxI=;
	b=1ykdfWEqERs6z+sN+CC5mt7JT2VWDpWx+RG3bRRhW8U55w1uQua/IbtYuEg/kbtdr87hf2
	u4V7SRRmflZZETm2hsT+zq3gRwKtaniD+qYVXzeqQnwdBYtU973l+PWGXYFGA1TnuzAvqL
	LqT8E2VJPSQO84hfFWgosMFZmPDUTCwbLjpD9CEig+bUBSqmZIEq2G3BN55LWuz34xwXdn
	cWou0jcsmrsPsiIrsZ+YHqIPVOF1xojlW0M2fKNb0sipWU78FyhLX7Tzg++mMZfmkLPQzu
	bgInwvzw3s12+k3oFES0A4vLF+m2FY4ESnyVO2UlKndQ4ogjAGbHIqtDQI+Lfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydVul0a4FP+4PcNCblFv1cuoHBvYBqlDRcudAEX3HxI=;
	b=ANWS8DVaCIsH4vMRyvsNCOBy50NaPHu9JO4Rbf66Co8zWhL/qr3B+vfMXOXHoA/PEvVlwF
	3eKqauufaQpAiECw==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 25/28] kprobes: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:39 +0100
Message-ID: <20241220174731.514432-26-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_text_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_text_address()
with RCU.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b027a4030976a..22e47a27df4aa 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1566,7 +1566,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (ret)
 		return ret;
 	jump_label_lock();
-	preempt_disable();
+	rcu_read_lock();
=20
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod =3D NULL;
@@ -1612,7 +1612,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	}
=20
 out:
-	preempt_enable();
+	rcu_read_unlock();
 	jump_label_unlock();
=20
 	return ret;
--=20
2.45.2

