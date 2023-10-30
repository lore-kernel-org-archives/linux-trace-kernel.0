Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCD28EF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUX3M2Y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438AFC433C7;
	Mon, 30 Oct 2023 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698691449;
	bh=+7zhfHPyLzZwQQCV6hLW1IUskEnhha0OZ7HOdtRJlEw=;
	h=From:To:Cc:Subject:Date:From;
	b=qUX3M2Y62hDjwRfvptl4QHx+7+qPiybQHnaVZOd5ExmgUX4KKkGH7WyP3jQ3JTQ82
	 WiDn4k+cFjcIXM8x734Vlqy0IuOFTcLgtGIvqNMo/FR83vtYUOgPGGGFsnbaNHXW/a
	 zyOUmq7x/J5TGMinlhXlD8F342QUmqy8hnpRjS5Ju0IH1pSVMbV3BSYXUKU9vVcsNv
	 VviRBumEr0oVMe/wWnmMqG3iUzSM0Aj2RFRStlWA9LHV9KhCu4WP+K2JqVMQCbPqWE
	 MW8PZwStO9Taxho1wDRMxWyEUk28R1FCUiV1paHku5mMPSpMQztIjqILc/HCqbR9gI
	 dfzBlj5v8WCuw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] tracing/tools: Updates for 6.7
Date: Mon, 30 Oct 2023 19:44:00 +0100
Message-ID: <20231030184400.22645-1-bristot@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steven,

Tracing tools changes for 6.7:

RTLA:
  - On rtla/utils.c, initialize the 'found' variable to avoid garbage
    when a mount point is not found.

Verification:
  - Remove duplicated imports on dot2k python script


Please pull the latest tracing-tools-v6.7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
tracing-tools-v6.7

Tag SHA1: eadb7e76bc7ce4174d4905a29a4a07cd835508fe
Head SHA1: 696444a544ecd6d62c1edc89516b376cefb28929


Alessandro Carminati (Red Hat) (1):
      verification/dot2k: Delete duplicate imports

Colin Ian King (1):
      rtla: Fix uninitialized variable found

----
 tools/tracing/rtla/src/utils.c | 2 +-
 tools/verification/dot2/dot2k  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)
---------------------------
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 623a38908ed5..c769d7b3842c 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -538,7 +538,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 {
 	char mount_point[MAX_PATH];
 	char type[100];
-	int found;
+	int found = 0;
 	FILE *fp;
 
 	fp = fopen("/proc/mounts", "r");
diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 9dcd38abe20a..d4d7e52d549e 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -15,8 +15,6 @@ if __name__ == '__main__':
     import os
     import platform
     import sys
-    import sys
-    import argparse
 
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
     parser.add_argument('-d', "--dot", dest="dot_file", required=True)
