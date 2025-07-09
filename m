Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2142E4266;
	Wed,  9 Jul 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068989; cv=none; b=l3updz+E4/UA+qidxglpXpjqeal96+KQtcWML/WxcJOegjCEliBsx/NMw+VxrE2OnEn3Vrgd0mK2a/3g66NbGb1EFAnEFqDhG964xibdkpDVysAClmZGTz8OCKnDDlb/aaHPu+daEEM724eO5bMpymw0U7lSkVzITavDNoPMeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068989; c=relaxed/simple;
	bh=vyVIGCtc0jVROOiaoRDc63+XloT/k7Y60usHpVt467Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZQo7B18W9e0edPGhp8PbQi2avbwKQUNFdfasUxYs1AQnG1Gk3lK72aI12oCBYSPDLf3QGI/L00xx/uy4fupAcF7K52aeqqJpFFEUW68k67xtGvUHFRZH2t66F+TIr8uYg1SOIngwbLOGHNa9hSGU+0FWQZiwDx0It5+albtiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et5FV+0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et5FV+0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C13C4CEF4;
	Wed,  9 Jul 2025 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752068988;
	bh=vyVIGCtc0jVROOiaoRDc63+XloT/k7Y60usHpVt467Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Et5FV+0ADwZBa7ZC5uNEgDWPKMDofqqx7qOQ+s9lYbb3CMnSMy57OdiPDnvMQZsp2
	 taoKecEZFNt3sN8ocvrmnUxUWkrGSqJEg/cwERxPFEXwqlgabCSFkcbusjfZNSW6wM
	 Z4kJZqYUnmJeT3hDhJHJf8hhTQhHHQH/0q9gC4HkyTqRRXI0h7Z7YabVox09Kt/lP+
	 Wkq+Vw4fPRRRUHU62XJXBnZy35KhN1qCwJBoThgf09DeMsPRDdgxrs2LIPYzUydNtE
	 ECGyOPNuk+J7jM2WZ+cnmAlLbJBydE2lLzHspDLAltASfu73yweEhxkqbcxTAYjJN3
	 G51mACWMuXuVQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 1/8] execmem: drop unused execmem_update_copy()
Date: Wed,  9 Jul 2025 16:49:26 +0300
Message-ID: <20250709134933.3848895-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709134933.3848895-1-rppt@kernel.org>
References: <20250709134933.3848895-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The execmem_update_copy() that used text poking was required when memory
allocated from ROX cache was always read-only. Since now its permissions
can be switched to read-write there is no need in a function that updates
memory with text poking.

Remove it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/execmem.h | 13 -------------
 mm/execmem.c            |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 3be35680a54f..734fbe83d98e 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -185,19 +185,6 @@ DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
 struct vm_struct *execmem_vmap(size_t size);
 #endif
 
-/**
- * execmem_update_copy - copy an update to executable memory
- * @dst:  destination address to update
- * @src:  source address containing the data
- * @size: how many bytes of memory shold be copied
- *
- * Copy @size bytes from @src to @dst using text poking if the memory at
- * @dst is read-only.
- *
- * Return: a pointer to @dst or NULL on error
- */
-void *execmem_update_copy(void *dst, const void *src, size_t size);
-
 /**
  * execmem_is_rox - check if execmem is read-only
  * @type - the execmem type to check
diff --git a/mm/execmem.c b/mm/execmem.c
index 2b683e7d864d..0712ebb4eb77 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -399,11 +399,6 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
-void *execmem_update_copy(void *dst, const void *src, size_t size)
-{
-	return text_poke_copy(dst, src, size);
-}
-
 bool execmem_is_rox(enum execmem_type type)
 {
 	return !!(execmem_info->ranges[type].flags & EXECMEM_ROX_CACHE);
-- 
2.47.2

