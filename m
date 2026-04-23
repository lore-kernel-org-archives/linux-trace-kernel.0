Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB7309F1C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955490; cv=none; b=HDkpDQDVDcJBExMhpQDl6u8REaQuJ1Q8jsL4HY1bh+AZudln9lxdWsnyRr++SvFhyUJWHWAau1k9nwb2B0GJHpz0Jueti5QMsa5I/WoPGt7vsi22qSpWgC2ngax8LP7oaffFNIoT0ObS5Z/XySwLyXJCxrT1gOTyDb6gEGmIqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955490; c=relaxed/simple;
	bh=FLmw8y9bee+jgkpgyqiqwkyTo5kSNs5Qv3xG11mv+X8=;
	h=Date:Subject:To:Cc:Message-Id:From:Mime-Version; b=o4wUD7SGx6N4WRGe9vY/EV26EtZNKvKD977//nbvnAb7eh9y2DXtLzEs8OmXQ7MF2ji6BYyHVV/7vIfwneaBgLKkmkeTEdDOwIAROwAWC6n1DFeD41z319xYmDFn+Dt8+gRTU2sOaRz9ZrNtVH1bdtiwPGsyZ1YslXuG6vynoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b=jAOigZyM; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b="jAOigZyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unknownbbqr.xyz;
 q=dns/txt; s=brevo1; bh=VxMzBlGGP8LlVdqve9WqVnkfaP5ve6f8jlSoq6iivKQ=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=jAOigZyMsOsEs7THH2wqQqyBVBNTp3lHZNXfRLNLCxyee4bzYpJOvwfxdzmevvGyBqeCqBwKmRWX
        VenjEykERkVm/WS1Owf3DBAHgDeYou4EcpSmnv1L1DyNLccGjTl6MEqgMBfOhEsC4hC2SMXkYQYY
        cL0H8FlLikKC13Me++yszrJ0UaEUMFg9bbSkQbmrdeBkImKTF9Hm/JuZglLtRW1l6bygvTIcPGQe
        sdzlp4b79j5ADlAGpAgpx9uRZnF0qgAyc8RbKv0mgK6tXgxcPCwPIKUv4QsEJNWGb2yuoTCizMQ4
        fPOGS9TYt1eRWKUpAikWC2ozQReSPKcJCs949g==
X-Mailin-EID: NDQzNzMzMzgyfmxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNDIzMTQ0NDQxLjI5OTUtMS1kZXZAdW5rbm93bmJicXIueHl6Pn5nei5kLnNlbmRlci1zaWIuY29t
Date: Thu, 23 Apr 2026 17:44:41 +0300
Subject: [PATCH] tools/rv: harden monitor name lookup bounds checks
Origin-messageId: <20260423144441.2995-1-dev@unknownbbqr.xyz>
Feedback-ID: 77.32.148.26:10473219_-1:10473219:Sendinblue
To: <rostedt@goodmis.org>,<gmonaco@redhat.com>
X-sib-id: yanvLB4YNvXvl65L95zD-wFPAGsa3zLgsPqrrPPDBhX8CYETrKeJizZSDphmTFfbuoYzldAnHqZhVzcA7KIIvF4-IjtvxQXtXRtTMsn8TbMm4wPiAs_tdpmrz4pbEG7cB-sXBoOH82tx1Ftg_qfH6YBnTFxAfTG2lO8ds4Q2FYKuoSDgZHm2_3VIia-v4E3X_g
Cc: <linux-trace-kernel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "unknownbbqrx" <dev@unknownbbqr.xyz>
Message-Id: <69972ccf-31ee-4906-9907-0ead76bd60b9@smtp-relay.sendinblue.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: "unknownbbqrx" <dev@unknownbbqr.xyz>
X-CSA-Complaints: csa-complaints@eco.de
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0


Bound monitor-name derived copies in __ikm_find_monitor_name() and avoid un=
bounded writes from sprintf()/memcpy().

Pass the output buffer size from the caller, validate extracted line length=
 from rv/available_monitors, and use snprintf() with truncation checks when=
 building container monitor names.

Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>
---
 tools/verification/rv/src/in_kernel.c | 34 +++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/=
src/in_kernel.c
index d32453824..f17eac9b6 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -56,9 +56,12 @@ static int __ikm_read_enable(char *monitor_name)
  * The string out_name is populated with the full name, which can be
  * equal to monitor_name or container/monitor_name if nested
  */
-static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
+static int __ikm_find_monitor_name(char *monitor_name, char *out_name,
+				  size_t out_name_size)
 {
-	char *available_monitors, container[MAX_DA_NAME_LEN+1], *cursor, *end;
+	char *available_monitors, container[MAX_DA_NAME_LEN + 2], *cursor, *end;
+	size_t len;
+	int n;
 	int retval =3D 1;
=20
 	available_monitors =3D tracefs_instance_file_read(NULL, "rv/available_mon=
itors", NULL);
@@ -72,17 +75,34 @@ static int __ikm_find_monitor_name(char *monitor_name, =
char *out_name)
 	}
=20
 	for (; cursor > available_monitors; cursor--)
-		if (*(cursor-1) =3D=3D '\n')
+		if (*(cursor - 1) =3D=3D '\n')
 			break;
+
 	end =3D strstr(cursor, "\n");
-	memcpy(out_name, cursor, end-cursor);
-	out_name[end-cursor] =3D '\0';
+	if (!end) {
+		retval =3D -1;
+		goto out_free;
+	}
+
+	len =3D end - cursor;
+	if (len >=3D out_name_size) {
+		retval =3D -1;
+		goto out_free;
+	}
+
+	memcpy(out_name, cursor, len);
+	out_name[len] =3D '\0';
=20
 	cursor =3D strstr(out_name, ":");
 	if (cursor)
 		*cursor =3D '/';
 	else {
-		sprintf(container, "%s:", monitor_name);
+		n =3D snprintf(container, sizeof(container), "%s:", monitor_name);
+		if (n < 0 || (size_t)n >=3D sizeof(container)) {
+			retval =3D -1;
+			goto out_free;
+		}
+
 		if (strstr(available_monitors, container))
 			config_is_container =3D 1;
 	}
@@ -782,7 +802,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char =
**argv)
 	else
 		nested_name =3D monitor_name;
=20
-	retval =3D __ikm_find_monitor_name(monitor_name, full_name);
+	retval =3D __ikm_find_monitor_name(monitor_name, full_name, sizeof(full_n=
ame));
 	if (!retval)
 		return 0;
 	if (retval < 0) {

base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
prerequisite-patch-id: b61dd51dee390277603975bf729a687113185c3a
--=20
2.53.0



