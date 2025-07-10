Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565B19D065;
	Thu, 10 Jul 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114252; cv=none; b=kiyYaF3669+cmWh5005jHONrhjGD2h9o7L6I8FXUHTn5mPf3CvypLNMirLck3bDZ0mgFISn9Ckr2MOsRM248J8eaNW005fC97q0HiPuSORAeYKLkU15inx5zfyw6sQI9rzldyTMerYiDy6sHYG/Yc4ppPxQ5P1hULZCPR1GAYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114252; c=relaxed/simple;
	bh=eNUYIuBrI00d0BN0sGSJNg9zzMel1CtWv7LSmD+61UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o59/FPKPDUBaas0AFEI7blRuCX5+jf8ag2oGXh2I+mgCI9aUurNgvJ6PHaV6jScD1ga/sSd/ioXCCAeDOf6PODOq5+KDup7KJIW52v3em79JIq92gwEw1sEbavaXWcRUDycO0TME29Bl3eCBABcF3k1+rFkkTr7Q944uPHjSeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZLTSEBQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZLTSEBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD37C4CEEF;
	Thu, 10 Jul 2025 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114251;
	bh=eNUYIuBrI00d0BN0sGSJNg9zzMel1CtWv7LSmD+61UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZLTSEBQLXORN0Jt4WCZn8woUuX3sBJRIBfv0jqtoKuTpiCC5HSKpBEnCYJian/Wg
	 NxG76tnfKOnQ0vRFcrQJaENtSZl8teXS1zl+ET8yUDOr3xUJCJTu/BPjn1UZqlkY4E
	 /Hyx+J5ApotefrszGpNmreBkrVwv2/3a0QEH45FFKdpJ91wzm1ebdFOQq+kLQtkYPL
	 zlZqtk1h/vtltsLXRxSC8whuE/OAoA4RCSw/zEexIiST85zVXdksMlHEpZPmZGuysa
	 1klIXIFSuahcr5eKxcZ/mfYRvPqDSCa3Lzw01EOMY6b88tGnJe61uPrRsfmunvhF8o
	 k/n9BoXzzd0MQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] tools/bootconfig: Replace some echo with printf for more portability
Date: Thu, 10 Jul 2025 11:24:09 +0900
Message-ID:  <175211424942.2591046.5439447789303314213.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175211423307.2591046.14863142130524442068.stgit@mhiramat.tok.corp.google.com>
References:  <175211423307.2591046.14863142130524442068.stgit@mhiramat.tok.corp.google.com>
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

Since echo is not portable, use printf instead. This fixes a wrong
test result formatting in some environment. (showing "\t\t[OK]")
Also this uses printf command for generating test data instead of
echo.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 127172945893..93f963c7d619 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -27,16 +27,16 @@ NO=1
 
 xpass() { # pass test command
   echo "test case $NO ($*)... "
-  if ! ($@ && echo "\t\t[OK]"); then
-     echo "\t\t[NG]"; NG=$((NG + 1))
+  if ! ($@ && printf "\t\t[OK]\n"); then
+     printf "\t\t[NG]\n"; NG=$((NG + 1))
   fi
   NO=$((NO + 1))
 }
 
 xfail() { # fail test command
   echo "test case $NO ($*)... "
-  if ! (! $@ && echo "\t\t[OK]"); then
-     echo "\t\t[NG]"; NG=$((NG + 1))
+  if ! (! $@ && printf "\t\t[OK]\n"); then
+     printf "\t\t[NG]\n"; NG=$((NG + 1))
   fi
   NO=$((NO + 1))
 }
@@ -48,7 +48,7 @@ echo "Delete command should success without bootconfig"
 xpass $BOOTCONF -d $INITRD
 
 dd if=/dev/zero of=$INITRD bs=4096 count=1
-echo "key = value;" > $TEMPCONF
+printf "key = value;" > $TEMPCONF
 bconf_size=$(wc -c < $TEMPCONF)
 initrd_size=$(wc -c < $INITRD)
 
@@ -97,20 +97,20 @@ BEGIN {
 ' > $TEMPCONF
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
-echo "badnode" >> $TEMPCONF
+printf "badnode\n" >> $TEMPCONF
 xfail $BOOTCONF -a $TEMPCONF $INITRD
 
 echo "Max filesize check"
 
 # Max size is 32767 (including terminal byte)
-echo -n "data = \"" > $TEMPCONF
+printf "data = \"" > $TEMPCONF
 dd if=/dev/urandom bs=768 count=32 | base64 -w0 >> $TEMPCONF
-echo "\"" >> $TEMPCONF
+printf "\"\n" >> $TEMPCONF
 xfail $BOOTCONF -a $TEMPCONF $INITRD
 
 dd if=$TEMPCONF of=$OUTFILE bs=1 count=32764
 cp $OUTFILE $TEMPCONF
-echo "\"" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
+printf "\"\n" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
 echo "Adding same-key values"
@@ -140,7 +140,7 @@ xfail grep -q "baz" $OUTFILE
 xpass grep -q "qux" $OUTFILE
 
 echo "Double/single quotes test"
-echo "key = '\"string\"';" > $TEMPCONF
+printf "key = '\"string\"';" > $TEMPCONF
 $BOOTCONF -a $TEMPCONF $INITRD
 $BOOTCONF $INITRD > $TEMPCONF
 cat $TEMPCONF

