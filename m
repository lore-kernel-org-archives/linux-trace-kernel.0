Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600921C17D;
	Thu, 11 Sep 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606217; cv=none; b=EIghaJPq+ot4LhNXgGoYbx9I+RaVE/NguylsfuwffXPCjlEIGlrqHQT1PJOvIbvUfXjWf1EPkNqpnmWQ2GRF0L1CfNS6ZjdepknzKxZz7yUS9gk8q9DLGsEEK1X3ZvRzpyifQtNXhqQOY84Rwh1iPt1koiTkTGi7Am3JWdCJSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606217; c=relaxed/simple;
	bh=uYQoJ8DmKxwuZVDUtDLgM2EFNWwooLacDimwsOtLlOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=egjeO13GZG/q6CP8ReTJDsKtppSDHzdY+693OJ2xTRar89785eiQ4udXbj4XwN72GMSek1KMEHQNDIPtxUHjVXTUA2Vmaf5otURwZBTRew2OgYfdherQ42eY/3nbju+cjxaeMxCm5W00GFMxWG8SvbDDQtrusLH51VXWj7cLe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AF15A1199DD;
	Thu, 11 Sep 2025 15:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 2D6F218;
	Thu, 11 Sep 2025 15:56:52 +0000 (UTC)
Date: Thu, 11 Sep 2025 11:57:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] rv: Add Gabriele Monaco as maintainer for Runtime
 Verification
Message-ID: <20250911115744.66ccade3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zrp5wyknhbynjx4exdhweupa4xumhieg
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2D6F218
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rzrVYCXXIkn/2m1CXtLNslN64FjSIT88=
X-HE-Tag: 1757606212-483953
X-HE-Meta: U2FsdGVkX1/siI8TarA4ncG0767dmo4WXZ0CFVAdxbKWqGI5BQvLQ+uXYi/MbrzwakCd1wDYm1C8vWqFkX04zN+ykzRCuctDY4G8jpCOMu7l1onkhv+RU7t0oqsjxxHBFMwTnJAOi2I25r356FKTPbjKkVW7nfjrFWU8p+4ke2TepAiriQzlzmjrCy40MUn0IN/LaLiGTTPKWFL6/KMeRmXsp2n8NUp2AimVynZYUjm0AWLBDZIba+h3/Qwkw+H7kHXCLY8nWGUSyf6ZB4xrrTsFjPEBuO17UWjuD///i9UAPLKJe6Q7V6cm/6oftmZzI5Iec5CPbULiNZMs2yZScEx287q8yE0yfITyv0wx6Hf5xphKdT0RKEMVn583zDFr+vShIocEnePk5iAY3NyBgl9MEKbxyQI6GTzbg+ANICQWDVglOJF9LZGsLkOZoZqmfnySXYGuQ6M=

From: Steven Rostedt <rostedt@goodmis.org>

Gabriele will start taking over managing the changes to the Runtime
Verification. Make him officially one of the maintainers.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..689d690d85ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22046,6 +22046,7 @@ F:	drivers/infiniband/ulp/rtrs/
 
 RUNTIME VERIFICATION (RV)
 M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Gabriele Monaco <gmonaco@redhat.com>
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/trace/rv/
-- 
2.50.1

