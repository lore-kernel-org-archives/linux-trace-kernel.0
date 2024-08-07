Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF71422D5;
	Wed,  7 Aug 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064431; cv=none; b=tKEu2Cy6GMdTG+My6x+Mo+R4kxEtkRNaTAG0NepeWGUw3wacRpL5XVSGaXiFoY/gcG+LaYDlh8MMxcr5XkIi3f2vtw6UZpFjdO4q/4bQ6zsqG10NgovJ9zxrPO4D3snQVrS2n4IB3koGjFdBminmAZjS5YruhFMhM8OSZuCseBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064431; c=relaxed/simple;
	bh=X+Ll5BBGlCfJJhWXkpa0zwIju42PoV8MDuvOtuyKQ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VxoiBffjcNP23eQNU3ugMPp/+gGUC0e3m9xCo6rDAzDVwT1xcgvcKObT39ZD5bZ3Ay/CecSmcf2J2DIqz7IwGUz4OsIxeCanrxKAmciiQUnMrlb0hrjozBc+40y5XUbdtMJhfFUq71F/YoLZJaRIRxBj7bQj1OH9vkRNvaMNNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F237C32781;
	Wed,  7 Aug 2024 21:00:30 +0000 (UTC)
Date: Wed, 7 Aug 2024 17:00:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme
 G. Piccoli", Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
 <rppt@kernel.org>
Subject: [PATCH] pstore/ramoops: Fix typo as there is no "reserver"
Message-ID: <20240807170029.3c1ff651@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

For some reason my finger always hits the 'r' after typing "reserve".
Fix the typo in the Documentation example.

Fixes: d9d814eebb1ae ("pstore/ramoops: Add ramoops.mem_name= command line option")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I did have this fixed, but the previous version was pulled:
  https://lore.kernel.org/linux-trace-kernel/20240613233446.283241953@goodmis.org/

 Documentation/admin-guide/ramoops.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index 6f534a707b2a..2eabef31220d 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -129,7 +129,7 @@ Setting the ramoops parameters can be done in several different manners:
     takes a size, alignment and name as arguments. The name is used
     to map the memory to a label that can be retrieved by ramoops.
 
-	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
+	reserve_mem=2M:4096:oops  ramoops.mem_name=oops
 
 You can specify either RAM memory or peripheral devices' memory. However, when
 specifying RAM, be sure to reserve the memory by issuing memblock_reserve()
-- 
2.43.0

