Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5C31E84C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954060; cv=none; b=hJtNthyOhozUlXHxInjBLq2VsIOfk8GyIG8pVqIeFw4ijGgq82AY5/fNTNE7kf3N7uUms1B4hBsVzVX+0ol3Q396RvcvHanMnwoCm4LOU/zXoFx6raHmUdiAy4F/6cuVay+gmoTcRNZi6QvpsI/rdiBWMBKpWjmFeYCcm1Qez1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954060; c=relaxed/simple;
	bh=PrOvaYNqLl6FZL25hsxuCziM5y+aRurnLiO/Mc1MISM=;
	h=Subject:Message-Id:From:To:Cc:Date:Mime-Version; b=YOeEJEW6jA4F3grxZR+HLdr3hqFJUfHj3XdmnvKOztXtz6YXgBKDSWotHgExDT0Xc6AGzMusaYgFM/umlOpNPl6rBNPot5elW29rYbFEIFKmjKz3oQNGjKecnH3qAYUXunexFtE5SaoZZ8urc70d1u+xiTEl9WvooqwqGeiIYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b=b5nAplWx; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b="b5nAplWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unknownbbqr.xyz;
 q=dns/txt; s=brevo1; bh=qWvxM+0TvRd0RhcKfb07zqlfXN4cg1w6cMRoZUQsfHw=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=b5nAplWxDq8GnTkFJn5hgyoBevpn2UCR3L62OMHIqPcrvQ+qLE7DuZmJdMWqgWnqfs+uQacoUam6
        8hGlDmENyqacihiuSrD0qOoktYtJutPHBGnSwshUvPcNqEn4kNmK37zl+Lzit8kAUp61wXim4Q3s
        pM9qzogk5QPgQql5wdv7OHUcgDGNzRmyajUxq9clKmdczXiGsaB5Cj799ok2nfDSnLUDo8a9r6e9
        LZoxMzlfsvN0hFxyyznNkPI1s3asLEMl57cDomFP6U0eATJGlOER7rPRFpoZ72/ZN/SxVTjzDZa2
        XPAdC2dDbWXncaN0WUTR8kbxgvc+18L3kNH5hg==
Subject: [PATCH 1/1] tools/rv: ensure monitor name and desc are NUL-terminated
X-sib-id: sp0VQd3XrBv6EOXu293iJhbJLcn37PW2qZMhtbD9dT0tGRwG1AdhWJ-51BHwgsVa31q6TFXKNZ1aUpgdclWTJFG9OUycw4wdtt8_HdG2PUYDwXx4j-w32C_vxaOGD3j2CodINipKW_byMU93O3p93MRDvFsOkBMTrpj2WG6SExcIBVEGWTmQemMI50H7Y2dpTg
Message-Id: <dc9ea036-de62-4e1f-be63-8e14d675bcca@smtp-relay.sendinblue.com>
Origin-messageId: <20260423141944.1866-1-dev@unknownbbqr.xyz>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: "unknownbbqrx" <dev@unknownbbqr.xyz>
X-CSA-Complaints: csa-complaints@eco.de
X-Mailin-EID: NDQzNzMzMzgyfmxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNDIzMTQxOTQ0LjE4NjYtMS1kZXZAdW5rbm93bmJicXIueHl6Pn5nei5kLnNlbmRlci1zaWIuY29t
To: <rostedt@goodmis.org>,<gmonaco@redhat.com>
Cc: <linux-trace-kernel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "unknownbbqrx" <dev@unknownbbqr.xyz>
Feedback-ID: 77.32.148.26:10473219_-1:10473219:Sendinblue
Date: Thu, 23 Apr 2026 17:19:44 +0300
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0


ikm_fill_monitor_definition() copies monitor name and description with
strncpy(), but does not guarantee NUL termination when source strings are
equal to or longer than the destination buffers.

Clamp copies to sizeof(dst) - 1 and explicitly append '\0' for both fields
to keep them safe for later string operations.

Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>
---
 tools/verification/rv/src/in_kernel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/=
src/in_kernel.c
index 4bb746ea6..d32453824 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -215,10 +215,11 @@ static int ikm_fill_monitor_definition(char *name, st=
ruct monitor *ikm, char *co
 		return -1;
 	}
=20
-	strncpy(ikm->name, nested_name, MAX_DA_NAME_LEN);
+	strncpy(ikm->name, nested_name, sizeof(ikm->name) - 1);
+	ikm->name[sizeof(ikm->name) - 1] =3D '\0';
 	ikm->enabled =3D enabled;
-	strncpy(ikm->desc, desc, MAX_DESCRIPTION);
-
+	strncpy(ikm->desc, desc, sizeof(ikm->desc) - 1);
+	ikm->desc[sizeof(ikm->desc) - 1] =3D '\0';
 	free(desc);
=20
 	return 0;
--=20
2.53.0



