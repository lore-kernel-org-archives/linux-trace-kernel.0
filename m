Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5119E96D;
	Thu, 18 Jun 2026 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790329; cv=none; b=G6cQBTVUna4CwlBkrWdPcGs3hiYDB+Jh3L2rsEbR58IV44Oua/eZEDJeX8bu0okoVnYjEZX2CFbJO7q51Owrin0OqEcQsT03p2i/U/XLdRez5VP6AuX2HXpsl+yfQSmOwyKnpVUHZSQIxg4XXC2MLKXqljD909yO3VVwQXDNnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790329; c=relaxed/simple;
	bh=PShIqshMvvS0vi1hQjCg38YYWjwzyHtKctaEZPvleX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=unqVSxqkZAt8yYuucZg9sgsO0nhr+qJLVgxqjajUCZ/z+mizUi++lnx9vkRnjfuVUxBXD1Tv56C/Iqg/EM1BnfMqPvnDSaonzBZ7nDPdgPkTuCTY3O88uihRpmyqgY02jW7CEtiOe+w9CniofLd184N2/oEMc5FOsTPUfYp8jNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJYeybWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJYeybWn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A26EC2BCC7;
	Thu, 18 Jun 2026 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781790328;
	bh=PShIqshMvvS0vi1hQjCg38YYWjwzyHtKctaEZPvleX4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IJYeybWn2hDpdgB4+Kqa9Bi8GAv/DKtG7C3o5E/tFEzHeP81O+cPrhog4+NfDYTgl
	 Q3qZz8HRU/vhUXWR6e+PXVmaZOIEhb5cCITPEwdDTO6iud5bhPggeQ3UGQ/uKvBC7W
	 jw8VUeh/D0gJnLSRjXnmuJDqJGGujdj50Xno+FUIMGOhhITu/ac08PjabN2nS7AYd+
	 IeWph6RgYLYxrTWs7GE0t4uwCi1nsIN3EZfu9SaMMPKvGP7YkaUsg1cK7iqoPJ0dsn
	 iNYli3584khyf4XBtmNIoUY5fJ/9XkJe5ufYR4R3HYhSEyYYPUhBw9DCVhkfDxIZyJ
	 wKK++Inqjjxwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41352CD98F2;
	Thu, 18 Jun 2026 13:45:28 +0000 (UTC)
From: Yu Chuanyu via B4 Relay <devnull+lucayu.alight.gmail.com@kernel.org>
Date: Thu, 18 Jun 2026 21:45:25 +0800
Subject: [PATCH] rv: update rvgen monitor synthesis documentation path
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-rvgen-doc-path-v1-1-9bcf0148417a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMPQ6DMAxA4asgz1jCVAk/V0EMNHHBDAElgJCi3
 L2hHb/hvQiBvXCAvojg+ZIgm8ugsgCzTG5mFJsNdVXrSlOL/prZod0M7tOxIJHulFENqZeFHO2
 eP3L/hsP4dzjfK5vjuUBKX6t02E5yAAAA
X-Change-ID: 20260618-rvgen-doc-path-11695c57153d
To: Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yu Chuanyu <lucayu.alight@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781790327; l=1613;
 i=lucayu.alight@gmail.com; s=20260618; h=from:subject:message-id;
 bh=y70STU5WqHnmEwXDM8h6KvVTXzM4TCAuCZacgD+U7dQ=;
 b=jSEZoSXn/v+7KQENCUJMEVyZ9FtE804yj7QnCoqv/t6YPLvxrUDEdubT7WWpGdk+5aa1ci2Vc
 9TeLa2/k1z6CV0ic8hGvnJjDNtYns/lVbBzCkQ/CKb+zbJP4AkGIMjv
X-Developer-Key: i=lucayu.alight@gmail.com; a=ed25519;
 pk=ctVJlHrt5LLZUQdDrVWTtL5fYY5bukfU6L4wkFzuvZk=
X-Endpoint-Received: by B4 Relay for lucayu.alight@gmail.com/20260618 with
 auth_id=830
X-Original-From: Yu Chuanyu <lucayu.alight@gmail.com>
Reply-To: lucayu.alight@gmail.com

From: Yu Chuanyu <lucayu.alight@gmail.com>

The rvgen source comments still refer to da_monitor_synthesis.rst, which
no longer exists. The documentation is now available in
monitor_synthesis.rst. Update both references to point to the current
file.

Signed-off-by: Yu Chuanyu <lucayu.alight@gmail.com>
---
 tools/verification/rvgen/__main__.py    | 2 +-
 tools/verification/rvgen/rvgen/dot2k.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 5c923dc..2a2bb03 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -6,7 +6,7 @@
 # dot2k: transform dot files into a monitor for the Linux kernel.
 #
 # For further information, see:
-#   Documentation/trace/rv/da_monitor_synthesis.rst
+#   Documentation/trace/rv/monitor_synthesis.rst
 
 if __name__ == '__main__':
     from rvgen.dot2k import da2k, ha2k
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 110cfd6..326984f 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -6,7 +6,7 @@
 # dot2k: transform dot files into a monitor for the Linux kernel.
 #
 # For further information, see:
-#   Documentation/trace/rv/da_monitor_synthesis.rst
+#   Documentation/trace/rv/monitor_synthesis.rst
 
 from collections import deque
 from .dot2c import Dot2c

---
base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
change-id: 20260618-rvgen-doc-path-11695c57153d

Best regards,
--  
Yu Chuanyu <lucayu.alight@gmail.com>


