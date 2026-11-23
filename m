Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402070;
	b=yvGikpQ+1jrWMI4gvua8PGoB1joM/nFViJGDMdredwhQz7MXCQRzCTOcUE5d2KlLrxKa
	 jhjP4t3/fLeNAwKDujsxdSTJf0sGbBOnV/eWPCrjFwP2fnOvHkJy24u3qSSkYLh2ym1ZK
	 c3mF2LHgfPpg893cqqNhEwYhD1NHqPPZkZsKO971gWth4V/Hx3bwcWQxT7p9MRjBT/Ay1
	 0NobgNhHPqEKMpbacQcTk1KCDW5NpkrrQZBboGyk4E1qGDyeXGrBrhlN7nzuANvuZwGbc
	 0X9Dv3r0YQW9kBRMeQwaZZEse+pfLjDWJe3xklOYMuEZ6xqUEWqO9E2zLJO70xGsxdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w/EDch5cn3q5fGmwJDkw1LiwddtdffCknsqNOpXSWKo=;
	b=FpMQTwlVNgwjeevcYhk5/c6DsMrgYeALYjeX0lRVRnUtRcvsTYo5WmBrENCZxAMzP/xM
	 SIxotn8Uf9Gse6qSBP2z0lAMc0qNkEEQZbrCruhXWFww4a90gR2a6xNTBSWhic3ReQC14
	 thD3lNyqquGYHnA9ol3eVrLApEk1zOCZY0kFw+dblsn4HZppBU3W7CZaYPeG/XDEzQf17
	 VbPB/wJPkAPW+BBJ71lF+Pqpz02Rt3XTWNAM4WIt6C5glRFqhdJd2hQcJiH5AW618XVe3
	 l+RWOJno6m8aXbNAbu1V64fhG4XUcA4n0GJ9JB8LBadnECtHjGMR4ctBxH/mg46RGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/Wbqf0a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B2606A31A;
	Mon, 23 Nov 2026 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/Wbqf0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9A71F000CF;
	Mon, 23 Nov 2026 02:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402069;
	bh=w/EDch5cn3q5fGmwJDkw1LiwddtdffCknsqNOpXSWKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/Wbqf0aiFlLq+dVgb7Jh5UkkAXZznHLQDCfFrIci4wio3CzgKQuOoqj26RhOUoRg
	 IGwiF9NQvM1xt9a49knvRK2VBJqSVVMY9dShPYkT+d/1G95fmoRpNrsr1gnnMWwfKi
	 elqUhdlbrO2PZ9JaOZUWm9e+j976xeRZUm0Ywa6mqdAI42xhjMplcY/QcqUUSUYtdT
	 ql3MXLFSk9YpKtkQlTBXPGDQ+MsblQPTP5+gouEDiXUAgn87hASpoffGaSHZzro188
	 VNwegnqxRBkXYYhb5JuDPb44qTiB0IcgNq2b88G3y/QFaYIIPcyZqI+wpWTHv7VN3S
	 0SXQM1HgxSS9A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Lukas Zobernig <lukas.zobernig@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Pablo Fraile Alonso <pablo@pablofraile.net>,
	Edgecombe Rick P <rick.p.edgecombe@intel.com>
Subject: [PATCH 3/5] x86/insn: Reject invalid REX2 encodings in insn_get_opcode()
Date: Mon, 23 Nov 2026 11:47:44 +0900
Message-ID: <179540206412.233843.17514240300180929695.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179540203033.233843.12951034848925983867.stgit@devnote2>
References: <179540203033.233843.12951034848925983867.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

Although INAT_NO_REX2 and INAT_REX2_VARIANT attributes are generated from
x86-opcode-map.txt, insn_get_opcode() never checked them for REX2-prefixed
instructions. It also accepted REX2 M0=0 followed by an escape byte (0x0f),
legacy/REX/REX2/VEX prefix bytes, or 64-bit invalid opcodes, as well as
REX2 M0=1 followed by 3-byte escape opcodes (0x38/0x3a) or VEX-only
opcodes.

In particular, REX2 M0=0 + 0x0f (0xd5 0x00 0x0f) returned success with
opcode.bytes[0] = 0x0f and opcode.nbytes = 1, which can confuse callers
such as uprobes.

Add inat_is_no_rex2() and inat_is_rex2_variant() helpers and reject
invalid REX2 encodings with -EINVAL in insn_get_opcode().

Fixes: eada38d575a2 ("x86/insn: Add support for REX2 prefix to the instruction decoder logic")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/inat.h       |   10 ++++++++++
 arch/x86/lib/insn.c               |   16 ++++++++++++++++
 tools/arch/x86/include/asm/inat.h |   10 ++++++++++
 tools/arch/x86/lib/insn.c         |   16 ++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 1b3060a3425c..26edd32dbabc 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -263,4 +263,14 @@ static inline int inat_is_invalid64(insn_attr_t attr)
 {
 	return attr & INAT_INV64;
 }
+
+static inline int inat_is_no_rex2(insn_attr_t attr)
+{
+	return attr & INAT_NO_REX2;
+}
+
+static inline int inat_is_rex2_variant(insn_attr_t attr)
+{
+	return attr & INAT_REX2_VARIANT;
+}
 #endif
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 225af1399c9d..36c477daf370 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -335,6 +335,22 @@ int insn_get_opcode(struct insn *insn)
 			insn->attr = inat_get_escape_attribute(op, pfx_id, esc_attr);
 		} else {
 			insn->attr = inat_get_opcode_attribute(op);
+			if (inat_is_legacy_prefix(insn->attr) ||
+			    inat_is_rex_prefix(insn->attr) ||
+			    inat_is_rex2_prefix(insn->attr) ||
+			    inat_is_vex_prefix(insn->attr) ||
+			    inat_is_invalid64(insn->attr)) {
+				insn->attr = 0;
+				return -EINVAL;
+			}
+		}
+		if (inat_is_escape(insn->attr) ||
+		    inat_must_vex(insn->attr) ||
+		    (inat_is_no_rex2(insn->attr) &&
+		     !inat_is_rex2_variant(insn->attr))) {
+			/* This instruction is bad */
+			insn->attr = 0;
+			return -EINVAL;
 		}
 		goto end;
 	}
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 099e926595bd..5e7648e50c2b 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -263,4 +263,14 @@ static inline int inat_is_invalid64(insn_attr_t attr)
 {
 	return attr & INAT_INV64;
 }
+
+static inline int inat_is_no_rex2(insn_attr_t attr)
+{
+	return attr & INAT_NO_REX2;
+}
+
+static inline int inat_is_rex2_variant(insn_attr_t attr)
+{
+	return attr & INAT_REX2_VARIANT;
+}
 #endif
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 1d1c57c74d1f..9eb81232874a 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -335,6 +335,22 @@ int insn_get_opcode(struct insn *insn)
 			insn->attr = inat_get_escape_attribute(op, pfx_id, esc_attr);
 		} else {
 			insn->attr = inat_get_opcode_attribute(op);
+			if (inat_is_legacy_prefix(insn->attr) ||
+			    inat_is_rex_prefix(insn->attr) ||
+			    inat_is_rex2_prefix(insn->attr) ||
+			    inat_is_vex_prefix(insn->attr) ||
+			    inat_is_invalid64(insn->attr)) {
+				insn->attr = 0;
+				return -EINVAL;
+			}
+		}
+		if (inat_is_escape(insn->attr) ||
+		    inat_must_vex(insn->attr) ||
+		    (inat_is_no_rex2(insn->attr) &&
+		     !inat_is_rex2_variant(insn->attr))) {
+			/* This instruction is bad */
+			insn->attr = 0;
+			return -EINVAL;
 		}
 		goto end;
 	}

