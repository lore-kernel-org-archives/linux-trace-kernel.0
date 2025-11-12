Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E133B977;
	Wed, 12 Nov 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965729; cv=none; b=nOgBjqbZsp7vZvmBI6klgtwQIpmvHinJOzlThj6hvHenS0vAhNdgqGo4MVbWjeTLKWwO7isCkeRpQANXJ+RRg/sBi85IaNb30oSW8e1Ea3NZZjDj2bWlYAC/c9GmfxkYQdlt620fp/o7CUvcgvozoRs1+n83/W2OYmUAfaQUzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965729; c=relaxed/simple;
	bh=XUlHr1sLgvDjgEANSq6/hOxPbp08g+wmtFX8QH4AtNo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cKUBsEaeVUes5CPxVRmr7zK7lEnC0ZKMt0KEsyPRVTXuaOxFcsBy9Hnmk7PvKmDeA/XtMx7shkOdSKhsCMkMc+Sv9Wah6fkjQCKdxdK+TJMv2ZmbOExip3WGDllNWCrQjSDzGsCBJFY+WcyZcB9YC+17v6JRt/vwGJIqMWXxk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EDED759B7D;
	Wed, 12 Nov 2025 16:35:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 1045C60011;
	Wed, 12 Nov 2025 16:35:42 +0000 (UTC)
Date: Wed, 12 Nov 2025 11:35:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>,
 John Kacur <jkacur@redhat.com>, Crystal Wood <crwood@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Add Tomas Glozar as a maintainer to RTLA tool
Message-ID: <20251112113556.47ec9d12@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1045C60011
X-Stat-Signature: anew8nbad8on4zwothct64ot1cfrj1uu
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18A4iwpcN6iSwH2bgQfoHEGKmK1O7Hcx8g=
X-HE-Tag: 1762965342-326454
X-HE-Meta: U2FsdGVkX1/Y7LtZbwmULy6u8+N126Bse1RKFff+f+X2Lr5EL+/fNeoNFsjDskJsnxeuNhsoy2olHzZtqBd+07l2urvqgJTzUeZVLI/Cyeb1o4DYPVPbaNHSfJNfOHFo0KTq3zNIkCunt0ll+UDFTiSubp0Er4sxaE/BtIC4mgvipcC1AYslKH3xNmBR1QyWf0u1bOGFxe3/ncPLpflsecwBSTra9P77L4EmsS0dzaV0xBr0Q6F2XRZ1PJuUBDQ0hzefbAs+OkfUm+mjKA+MvFEEsrRXFDL4ajtmKhaes/DU4o4s9WkpH+3yCN9G6MURj+zfKAbeitQgh94kY9Cq4FY1/ZbW9pzgs3kUC+AKARKdMRi9v/QQoPDqkQGihKmDw+XKiaDlI5DL7sew3fWjK9q3moPP6nyOk7g3dFZBETQ=

From: Steven Rostedt <rostedt@goodmis.org>

Tomas will start taking over managing the changes to the Real-time Linux
Analysis (RTLA) tool. Make him officially one of the maintainers.

Also update the RTLA entry to include the linux-kernel mailing list as
well as list the patchwork and git repository that the patches will go
through.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95c32cd3b524..238c3c368517 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21634,8 +21634,12 @@ F:	tools/testing/selftests/rtc/
 
 Real-time Linux Analysis (RTLA) tools
 M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Tomas Glozar <tglozar@redhat.com>
 L:	linux-trace-kernel@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
 
-- 
2.51.0

