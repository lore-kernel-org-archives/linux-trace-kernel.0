Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE471A267;
	Thu, 21 May 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375432; cv=none; b=pTOKy+6HPyuETxf+pAoUacFjnQXD9/ZHusuZZOZZndTBBViF2zRbjBaPwPDdWvUbbNKv6gZBYFRmBCrQkrWR3SD9rgV5hKerx3AZhP1sPyz4CbcuWmeN6AWkuQOf5vkzjauSM29BsvsuCJc0ZqHXFqrBmVR1VqnbvGdnmVe/R/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375432; c=relaxed/simple;
	bh=H7rHLuohSUHGiDGUItHF6BvncPvhNiHdSxCMO00/DmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzR1nG3fyF+p0AHvCKX2dIRmINQ1iyWmFsyRQLItC1UTUNyPOSXTEHJapB8pFhmWzva90koohPgyRc052DKtdm8MV97x0eOrmJfDiPB0TWMs/QZ5o+qDLVtWpRVA5ZWljARaZvfiizYhnWMiFWnc8QNv0dOL9RgcHoN2qAzAj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR+M+7BH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR+M+7BH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788E61F000E9;
	Thu, 21 May 2026 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375431;
	bh=ucm3WGheg1fg3Csw4ZgCRDSHUMdsx/Pk4haMkeNM9d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IR+M+7BHZ8Q1luz2m90tNml0JDP5fDr87CqUwj31VtgJB4ynIKQqKCNXLzM6FHPKh
	 aPBTD7ofmf21Lf/II6lfxNbEzNraadSH643VNb5uEuc7JFQjmG2WB6AWIEuS0/2+px
	 evluGf5Ul8kTNjPVNNeSgQ37GM3n/nlTnfl6Uz25+lP+H0ai1sl95B6gNX0jdYfDiz
	 4Dqxv6JUF9paa5b5rDqiI+JtkeNoQOqXxxhFVAzdsDEyNJdQEwN/8z3VP4Ksi15lZ4
	 XQmZOJxTUoESTfMz8auRfvsFYhytt0AQsi00RvAEEC+zETtlDa7NqwQV0MyaqOHu12
	 WQz1XCgM+WIag==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] random: Expose boot ID to other subsystems
Date: Thu, 21 May 2026 23:57:09 +0900
Message-ID:  <177937542892.2596845.4271730537688894501.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
In-Reply-To:  <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
References:  <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add get_boot_id() to expose current boot ID to other kernel subsystems.
Note that since this is only meaningful if user can access it via sysctl,
it returns NULL if CONFIG_SYSCTL=n.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 drivers/char/random.c  |   27 +++++++++++++++++++++------
 include/linux/random.h |    9 +++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b4da1fb976c1..96a5a165627a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1615,6 +1615,25 @@ static int sysctl_random_write_wakeup_bits = POOL_READY_BITS;
 static int sysctl_poolsize = POOL_BITS;
 static u8 sysctl_bootid[UUID_SIZE];
 
+/**
+ * get_boot_id - return the boot ID UUID
+ *
+ * This function returns a pointer to the boot ID UUID, which is generated on
+ * demand the first time this function is called. The boot ID is a UUID that
+ * is unique to each boot of the system.
+ */
+const u8 *get_boot_id(void)
+{
+	static DEFINE_SPINLOCK(bootid_spinlock);
+
+	spin_lock(&bootid_spinlock);
+	if (!sysctl_bootid[8])
+		generate_random_uuid(sysctl_bootid);
+	spin_unlock(&bootid_spinlock);
+
+	return sysctl_bootid;
+}
+
 /*
  * This function is used to return both the bootid UUID, and random
  * UUID. The difference is in whether table->data is NULL; if it is,
@@ -1638,12 +1657,8 @@ static int proc_do_uuid(const struct ctl_table *table, int write, void *buf,
 		uuid = tmp_uuid;
 		generate_random_uuid(uuid);
 	} else {
-		static DEFINE_SPINLOCK(bootid_spinlock);
-
-		spin_lock(&bootid_spinlock);
-		if (!uuid[8])
-			generate_random_uuid(uuid);
-		spin_unlock(&bootid_spinlock);
+		/* Ensure that the boot ID is initialized. */
+		get_boot_id();
 	}
 
 	snprintf(uuid_string, sizeof(uuid_string), "%pU", uuid);
diff --git a/include/linux/random.h b/include/linux/random.h
index 8a8064dc3970..aaf630f14931 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -130,6 +130,15 @@ static inline int get_random_bytes_wait(void *buf, size_t nbytes)
 	return ret;
 }
 
+#ifdef CONFIG_SYSCTL
+const u8 *get_boot_id(void);
+#else
+static inline const u8 *get_boot_id(void)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);

