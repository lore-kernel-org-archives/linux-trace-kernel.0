Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013496;
	b=qZGvUXslcCZM+QWZ0T5h8R5xd6kzhsGU8tfPFsTF4ECBVFf6iQ5yxJM7FjYNGzq1VQjq
	 Li9ytB2fic09ywPf3FYRxKLruM99TYbEtRKEY2qNtAfgiPM6zyfIKJK1Jjlj4rucDt6dt
	 WIjNQ09nSVnrsivAz6/ojJzuWseRoOcZvHj+fnG/MvDxukWnPqxZoK71CqdXyhzrpuqcX
	 M+4UIMISNd1cq/k4+/usTgyiWcpEFEAEBv77/z4imBiP4bizd1fwqJT9yA8Z3yNe8DDge
	 blFwM4ogJuM/8dv3fjv+WURZHiLO6bvauWc40MVN4zVB3FPxktEYvqunvOpsa0zdJDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013496;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=U6FPJeVp8t/tfRRICPjUoC6PNDNnsdUBwnuvnfAniPQ=;
	b=q+U7DDl2hXplNGNBQmMVNbIRzAja1ZdZNGMGtq70B+r9Puu9j/qXLRyiPLrJiF91LGdz
	 CVT1n6EyhkWWBofTgO5bGfLSVZ1et368pZ/T2e0kp9JIFRApV8dfSzjDPqGbSUn7edSaO
	 eGeHWN/RA4Qmt2k985Yc4z4l7kNX7YqNwKjirMMCTPkIMamuhbW2I8Sau+Wg7709afUSY
	 9haJWE3FUWVQyiCK28d0jyWZgrDnun3Qnl1kSjzx+I5Iv9YkxreH04c4dSTPpXyseEOH8
	 ElMxmWseWsWv3H4Ls+9p0wg7Rv0dl5vIPd2qdDx21SChpEPUJNPqu0lvJQE2WI6Szpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b="di0/IsXl";
	arc=none smtp.remote-ip=212.77.101.9
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DF606A336
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 14:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB4DF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=di0/IsXl
Received: (wp-smtpd smtp.wp.pl 40525 invoked from network); 18 Nov 2026 15:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1795013486; bh=U6FPJeVp8t/tfRRICPjUoC6PNDNnsdUBwnuvnfAniPQ=;
          h=From:To:Cc:Subject;
          b=di0/IsXluofWfm0hHiB73a751u+lebaxE2SjivjCmiz3iwLNehq1jhxcj/K3tcP0a
           w7BxeCqff72LAKUoL7LXouni3ZBdDOpIYsAPCvFL29/8PYovrahgQpystFuacQdvug
           qL1JrHc/brT4QV+N4hNudjpayTowpGVhZ3jQhJ635QAFb8o4BPVsM/qtjlmFaNMuuD
           IpKtYSXNcSE8X5ilDnqtEJuruh6VTizrjldwr2yJ/6VqrGl+qZguaf6pJOi4AYazeS
           pZOSInJbyFe5noVau1zowxG/dxyQHxDTvhCYcojrZh5M14ri2WyL9Wy4B/MxDSfG8k
           e3n2RxiM3meOQ==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux-modules@vger.kernel.org>; 18 Nov 2026 15:51:26 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux-modules@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 1/3] module/kallsyms: include empty names in is_ignored_kernel_symbol()
Date: Wed, 18 Nov 2026 15:51:23 +0100
Message-ID: <20261118145125.29399-2-stf_xl@wp.pl>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261118145125.29399-1-stf_xl@wp.pl>
References: <20261118145125.29399-1-stf_xl@wp.pl>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 1a637cc0d3fd4a139767f2d741e40bcd
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [UbNk]                               

Both modpost and find_kallsyms_symbol() reject empty symbol names.
Handle them in the shared helper to avoid duplicating this check.

This also lets is_core_symbol() reject empty names referenced by a
nonzero st_name. The reserved ELF null symbol at index 0 is preserved
before calling the helper.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 include/linux/module_symbol.h | 6 ++++--
 kernel/module/kallsyms.c      | 7 +------
 scripts/mod/modpost.h         | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 698d3db2b37e..b93ef616a3f1 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -8,11 +8,13 @@ enum ksym_flags {
 };
 
 /*
- * Ignore local labels (.L*, L0*) and mapping symbols ($*). These symbols are
- * not useful for the kernel, for example, they should not appear in kallsyms.
+ * Ignore empty names, local labels (.L*, L0*) and mapping symbols ($*).
+ * These symbols are not useful for the kernel and should not appear in kallsyms.
  */
 static inline bool is_ignored_kernel_symbol(const char *str)
 {
+	if (!str[0])
+		return true;
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
 	if (str[0] == 'L' && str[1] == '0')
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1ff8ce857d92..5dae0832714a 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -292,12 +292,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		if (sym->st_shndx == SHN_UNDEF)
 			continue;
 
-		/*
-		 * We ignore unnamed symbols: they're uninformative
-		 * and inserted at a whim.
-		 */
-		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_ignored_kernel_symbol(kallsyms_symbol_name(kallsyms, i)))
+		if (is_ignored_kernel_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 666beca685e4..eb01108702be 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -196,7 +196,7 @@ static inline bool is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 {
 	const char *name = elf->strtab + sym->st_name;
 
-	if (!name || !strlen(name))
+	if (!name)
 		return false;
 	return !is_ignored_kernel_symbol(name);
 }
-- 
2.52.0

