Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79634F48A;
	Wed,  8 Apr 2026 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622766; cv=none; b=ECJftcLVH8bEoRGle7uCL96YAlipqY6PlhvXankt3MNb9lhubLjnwM66LXdtxtwyBVQqglW6dDGcFcdneXfIFKpQp1//SVNI2GLXLV6C86/Pd3F5cm7BigSogVsoqidG99neso1p5cxpHC3zD2YI18T18lmdx46uXTOnZXXoVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622766; c=relaxed/simple;
	bh=9MYLGKoExxzqbYH+tXIMtfX2X2p2rbS+DesZGGvbBL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlpmNy8SIdVwM+vW97+GQwa+Z/qPbXXMzTgLShBxSI7mbYoPiYl3+Zy2cR1wRjjYgg0Vandl0DDzdAChAWsuKwDh4FVjej2q0U7QIn9bVHuz+DcrKL9HswLO20m41RlrHBi0SGoRY3HoMgFzHSZm1xqcZakTcR+PqPR63494voQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ehZce+PB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ehZce+PB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=p/
	ZM/4kHelLiyLL8DHfGbrRahrKh1nTWWuGX6Oj+uks=; b=ehZce+PBzOZ32VQYdW
	UZ30kFRybbshcCP7goWt1rTanwUHVhCr9cpYY+/CMubfRhk3gGW5/jG/jDwsmdkW
	F+J52FtXHb0ZN3mHyjE6na8oJFNOuFLg1QZP17DVaVDKQ8YfFTxVlnP6Gdvz3lpG
	ETAOw5V0k5RLJhjrl1NcStYhY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn+sBS2tVpCHSdDw--.35311S2;
	Wed, 08 Apr 2026 12:32:20 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Quote check_requires comparisons
Date: Wed,  8 Apr 2026 12:32:12 +0800
Message-Id: <20260408043212.8063-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn+sBS2tVpCHSdDw--.35311S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF13GryftFW7CF17WFWruFg_yoW8ur4Up3
	93WFyqk3s5KF43t34UCr1DuFWxKF4ku3yUtw1rJFWUXw15Zas2qw1SkF13KFZ7Z3s8X34S
	9393ZF17KF4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJR67UUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6BSb1GnV2lTa4AAA37

check_requires() compares requirement strings that can contain shell
pattern characters such as '[' and ']'. Under /bin/sh, the unquoted
test expressions can emit 'unexpected operator' warnings while parsing
README-backed requirements.

Quote the relevant comparisons and path checks so the helper handles
those patterns without spurious shell warnings.

Validated by rerunning fprobe_syntax_errors.tc and confirming the
previous '/bin/sh: unexpected operator' lines disappear from the
detailed ftracetest log.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 tools/testing/selftests/ftrace/test.d/functions | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index e8e718139..442aa28ff 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -145,13 +145,13 @@ check_requires() { # Check required files and tracers
 	p=${i%:program}
         r=${i%:README}
         t=${i%:tracer}
-	if [ $p != $i ]; then
-	    if ! which $p ; then
+	if [ "$p" != "$i" ]; then
+	    if ! which "$p" ; then
                 echo "Required program $p is not found."
                 exit_unresolved
 	    fi
-        elif [ $t != $i ]; then
-            if ! grep -wq $t available_tracers ; then
+        elif [ "$t" != "$i" ]; then
+            if ! grep -wq "$t" available_tracers ; then
                 echo "Required tracer $t is not configured."
                 exit_unsupported
             fi
@@ -162,11 +162,11 @@ check_requires() { # Check required files and tracers
 	    else
 		test=$TRACING_DIR
 	    fi
-            if ! grep -Fq "$r" $test/README ; then
+            if ! grep -Fq "$r" "$test"/README ; then
                 echo "Required feature pattern \"$r\" is not in README."
                 exit_unsupported
             fi
-        elif [ ! -e $i ]; then
+        elif [ ! -e "$i" ]; then
             echo "Required feature interface $i doesn't exist."
             exit_unsupported
         fi
@@ -223,4 +223,4 @@ get_mnt_options() {
 	local opts=$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.*\)).*/\1/')
 
 	echo "$opts"
-}
\ No newline at end of file
+}
-- 
2.39.5 (Apple Git-154)

