Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013498;
	b=oBmmMj7bnNQ8ZUw8WH0lf5UGa9x4QCMOr8AHgQBNkx5Fy5dkZQDtlyxYFGGOTB4kJ2aE
	 czGjbHdOQrNAGt2qSA9IFlcu38qjjEa/1gkBotFmAsSXvB90cV9b4Yd5tkiCxzHuQvnFj
	 t33IikynqnWfMQBAkJLaQP9DrBT43KtR3z3DzDVxowVBXQUuo3B8pDLrLbxkpv29QyOtl
	 KsPKssXgKXASVPVICaO2vqyv306d+fRmoMBH0BcTmmcpmozbldsSWGd8zDmDSEbqzk8OI
	 EJLqgsy0c4XuDnvIA6FGdslgMLMqF+s7/8kqpQjWEdDTac16Q+f7VnAVz8MMLnUIz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013498;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=qIlU+acwKKLADzT+uV2Os4B10C9LyZY+L3QQctMtVJc=;
	b=SVtj5nvNQgfA+gIDU6dMeCdh1rOReP6nPQdh1zLGdPJVGWqo8S9kxthKhjv3bfE/ctdj
	 C99C0Gat0xFcWBihrtUudKZve+TN92pBn/maCbRc0lRABAjiyt3ZEDHw6H4x98Nztg1YZ
	 qUlHWx8i6xjdlmfv6ZH3XelUv64su2havuPuEf1Jt4Twq4GvZB6bgolk+Nd/Zftzs53dX
	 UGIM0tThggh1cxfcxbNf233y2dzMVomX9Smh1QJJqhS+LcYLtLHAXLrWxFxNBB3U9+wxu
	 5i59K+pCIfnyGy77VLSuKHmkjk5vbb+M4nmdSVT/mJq0UTECzEWjIAT1z+IB40gfYfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=U1cW69i1;
	arc=none smtp.remote-ip=212.77.101.12
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D860A2608
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 14:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544D860A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=U1cW69i1
Received: (wp-smtpd smtp.wp.pl 32397 invoked from network); 18 Nov 2026 15:51:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1795013489; bh=qIlU+acwKKLADzT+uV2Os4B10C9LyZY+L3QQctMtVJc=;
          h=From:To:Cc:Subject;
          b=U1cW69i1kK/3M1Tg+Vwq+lyvcC+AnoGtwMPqrMGMuiKIMPfqBtX+RcbIuRo9X9F+m
           iDa7KrNG5iikVNrfzSY2FU2uboP0LBXQCzWza+PFVIVs4E80nVkES3U6LV9kQTBoEh
           lP2ot58o9LDQ5aPAtSexE169ET+Noy4+AfF6kqTJGuGn5rByo3MmymmzwjFXav/z5J
           /nmnM42GfSCg7Yw5bGWykm1k8NWJUeQ6sSFeLR/rYNFYSmPQu5WcroXdQiD6Tr5b6t
           EWMjdyypYxURIH0XPlO88p0d6zWrKi3D+JPbiz0rG65Bkwt5/fiRwqoV9OiCuuI9MI
           dqJ/zqW3Vku7w==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux-modules@vger.kernel.org>; 18 Nov 2026 15:51:29 +0100
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
Subject: [PATCH v3 3/3] module/kallsyms: enable indexed text lookup for livepatch modules
Date: Wed, 18 Nov 2026 15:51:25 +0100
Message-ID: <20261118145125.29399-4-stf_xl@wp.pl>
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
X-WP-MailID: c227c8fff6f31584fbe9737559213126
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [4RME]                               

is_core_symbol() returns early for livepatch modules, preventing their
core text symbols from entering the sorted index. Address lookup
therefore falls back to a linear scan.

Allow eligible core text symbols to be indexed while preserving all
livepatch symbols, so core text address lookups can use binary search.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 kernel/module/kallsyms.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 4e7a1c5a3b8b..8f8ac540ab5f 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -82,17 +82,18 @@ static unsigned int is_core_symbol(struct module *mod,
 {
 	const Elf_Shdr *sec;
 	enum mod_mem_type type;
+	bool is_lp = is_livepatch_module(mod);
 
-	if (symnum == 0 || is_livepatch_module(mod))
+	if (symnum == 0)
 		return 1;
 
 	if (src->st_shndx == SHN_UNDEF ||
 	    src->st_shndx >= info->hdr->e_shnum ||
 	    !src->st_name)
-		return 0;
+		return is_lp;
 
 	if (is_ignored_kernel_symbol(&info->strtab[src->st_name]))
-		return 0;
+		return is_lp;
 
 #ifdef CONFIG_KALLSYMS_ALL
 	if (src->st_shndx == info->index.pcpu)
@@ -106,7 +107,7 @@ static unsigned int is_core_symbol(struct module *mod,
 	    || !(sec->sh_flags & SHF_EXECINSTR)
 #endif
 	    || mod_mem_type_is_init(type))
-		return 0;
+		return is_lp;
 
 	return 1 << (type == MOD_TEXT);
 }
-- 
2.52.0

