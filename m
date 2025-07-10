Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296C19D065;
	Thu, 10 Jul 2025 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114244; cv=none; b=RRKhFNJMHjdPxh/mBP3C2wE7M0W2jEE6TJvDze/xaiWNqpsYwcabtKtp2YRJzacgTFPtxl3y5z41HIugiAb3aIrV1eES+3zIoZijEIuZJLBRYNv/9hxS7X57b1o8H/2yIUJrsHMrOrywkHDhXce+iW4efYHu3PWdarITsBCmBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114244; c=relaxed/simple;
	bh=aAMyXEdcuY48zB4rC4Kk3joYJf7EmNBHzhBObCwMBn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsTWzGSSb/pQe+2IUXY71r6io+C0I8K9FVaOQTuiD52EfpJ+96Eiui4QxYPbC5TaHPeV4hx/6mw+AyhgXjAyqPSicuOILqgi/ltxy6P9Q2gykQUNg7XamqEKNpMbjY9X8rzw375JcBwKGjfgUhUj9tOXKMKLDhOCQzHVv2lIU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A49R0ZVU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A49R0ZVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A077BC4CEEF;
	Thu, 10 Jul 2025 02:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114244;
	bh=aAMyXEdcuY48zB4rC4Kk3joYJf7EmNBHzhBObCwMBn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A49R0ZVU9SjEAaGYx6FP/JCZ/1deONp/FqWqL6gYnlyHA2/bezvOGxr8usrqp16AD
	 ZfuAobRqmRM2gHO3x3/Ck98UifdPaHDvwNSPnPJOXQDP6LjzRjPsx9cE7Ff4ArADyN
	 SbJEw4wonw+5k5JPsYjOYPk3g+cBgN0IZ+nAMHYbyR2XHhRzmWiYtDPm0YsWfr352q
	 I54Ry/F7sAMy+72j3WZcm/qXtSwaHLtMdSei2Z6K3mJ5E50cZ93CmDNiMGSNTr+t/z
	 FLJTNeWuZHTiGXsCAvSXPBCiLnUEOUHsRmGicgcdGqiDHIB5IWHL6MJToQ0dd8fL/7
	 y93b6lFvUmspw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/3] tools/bootconfig: Improve portability
Date: Thu, 10 Jul 2025 11:24:02 +0900
Message-ID:  <175211424184.2591046.3523297993175066026.stgit@mhiramat.tok.corp.google.com>
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

Since 'stat' command and 'truncate' command are GNU extension,
use 'wc' and 'dd' commands instead.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2c484c243f5..127172945893 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -49,12 +49,12 @@ xpass $BOOTCONF -d $INITRD
 
 dd if=/dev/zero of=$INITRD bs=4096 count=1
 echo "key = value;" > $TEMPCONF
-bconf_size=$(stat -c %s $TEMPCONF)
-initrd_size=$(stat -c %s $INITRD)
+bconf_size=$(wc -c < $TEMPCONF)
+initrd_size=$(wc -c < $INITRD)
 
 echo "Apply command test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD
-new_size=$(stat -c %s $INITRD)
+new_size=$(wc -c < $INITRD)
 
 echo "Show command test"
 xpass $BOOTCONF $INITRD
@@ -69,13 +69,13 @@ echo "Apply command repeat test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
 echo "File size check"
-xpass test $new_size -eq $(stat -c %s $INITRD)
+xpass test $new_size -eq $(wc -c < $INITRD)
 
 echo "Delete command check"
 xpass $BOOTCONF -d $INITRD
 
 echo "File size check"
-new_size=$(stat -c %s $INITRD)
+new_size=$(wc -c < $INITRD)
 xpass test $new_size -eq $initrd_size
 
 echo "No error messge while applying"
@@ -108,7 +108,8 @@ dd if=/dev/urandom bs=768 count=32 | base64 -w0 >> $TEMPCONF
 echo "\"" >> $TEMPCONF
 xfail $BOOTCONF -a $TEMPCONF $INITRD
 
-truncate -s 32764 $TEMPCONF
+dd if=$TEMPCONF of=$OUTFILE bs=1 count=32764
+cp $OUTFILE $TEMPCONF
 echo "\"" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 

