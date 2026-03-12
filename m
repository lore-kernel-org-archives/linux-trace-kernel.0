Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2931E85A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341124; cv=none; b=R9UpRooSgghPbat04pYsf6WaxLE3SESxTQ0IE0m5zGfAP2JCnn1bCTaqxluliEHw4z7S3MQRb7cpLQh8bfSutr9s15nKGXdqSosfNKigQ85PxKa1GN/D4G4FUayggtd1k6JoofkG0ffGlMZ5vDjqqDY92uvPm5QmtRC/CTFj5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341124; c=relaxed/simple;
	bh=IGvEzpYaRLimGwvck9y9/u/ARgKxX4vdmL9hrr7TzZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpy1eIo88ji/YlG/oxR76ejn2eCLDlQOgyS/XadU+qr0tOc7VscV53AZkqPxU31kaMDq37pDu3Ouia+uf23MttxQN+b7G+xYA6rfFstfZFEJLilX5NB2BVrPrnaymJwFkeTEU7BmP1yxCUpAD0JMD/1/fCraUWy+Wb3nT1YMcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYNpDHXg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYNpDHXg"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a45bc61e9so11236741fa.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773341121; x=1773945921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzAvoq4uraTzTssrO28BscOnZK0V5B4etFhaIgkco6M=;
        b=dYNpDHXgfa5DGP09s0c/w9gdqr2qKzM403SeakN5GQUasTEuF7qfgATRG/0DD3hvaQ
         dL6EKDQE59W0hpa3+a0gYGTTMTNCHb/oV16Tn4NDhamwHeW3L9gyRXXwgHUI1rM/X2Ya
         WMYJoGce4g2swa+7LMlp7sVj3V9sM9Lv6lk5wKgFY++igalaDfqZcGpR0J0QIhR9fR9d
         84fYzpjpRUm2UDblgh5OyhU5A2clpvNhOmUkgKeeBTQJvWkYsq0fhZrMG5lOFTKJrt1t
         JPjvsTMELg7iRvDojamSIqIW99quCl067v1KNCgwKYd4hVjA2aR6rAI9UKg2b7stOlYV
         g17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341121; x=1773945921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzAvoq4uraTzTssrO28BscOnZK0V5B4etFhaIgkco6M=;
        b=dUrwIacwBB1ezx5/XMJ8pp3YtWMZXEJERM4+cfIK0EwfHioDnUf/buBySMJo9worrt
         XlX0DL1I/JPPX0vGrTdAUgySGRHqW3Gehkc6VZFtbteddqYCYJndUTz5UWZonDBoaFed
         eCPlgkJ4XBji1lx3ObX6nT/mvca66K/7gpBnj7fEa82b0ZuxWNYVGJ4XlLVdPBvOiFxS
         pdXtndU7sDq8D9qBEMQeEryRLBsWuP1vNJgMOMCnv2ATcj1V3nx8oPF3T5YkqMTFbnF3
         lQZQUf7oMuPFxAYEC9tZSRZLEAUSud5lceNJTIWJiX3NotyZXiewfhZAr2Nd2qYDbCa3
         I5iw==
X-Forwarded-Encrypted: i=1; AJvYcCXSJA61urnvaS2zjdtOB3EG1hg6F6m8aJzAzbH9df44SdRSoWDIMfgrjQVnyssYgCGQriHpJl5MehcIlaAABDLhhAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoyJix8Xt37VZeKvO4kvp+JAdUS/B/sMLkKnRvEZk24ERK0Mu
	ofw7fWkygyeAZ1sFJcf7Z4UVJphlPsbtk+Iq/Loh5UUcWX04te44ocCd
X-Gm-Gg: ATEYQzzj6kBXv0m6Z1/Jlxlx7obk2eHtyPx3r938YG3wMGj+8R755ZYN/Q8lEy0SQmT
	CQGvSWorKFK1YlBHlrtvoEg2r8EVJQumqKeClTd/JHwnI27aud91Co1ChqE4KUsTT8owKUq3tVk
	KqLilYpnQPf/iA/Z1GQy9tB8dvToRNdHOddgbb+9AoWpIf1+BAVXpag6SU8HfpvPrxbkUvqUuuX
	3R5Xmd8A1W8G4OUz+m7ddZ+foMHlLQ4w5dkWk/FgfMm5mOL50beqWzlSf4gjPQcyC06Cq1UM7C+
	WrcwlFzO3+/1Yvv/6COBStWLJ2VJJcij1fdWWaZcfnLx7LF/N2bkp39G7VATUyy1GvdAI15Axoj
	ErzHkPz9b4gJvX9MeqdI0x560A/pFPG+fdDmcYC4lJ4SRK1za+oe2sp25MQlsFkXRvYtuf/ERV5
	75fJEf+YIsO9ToXMxDtRVzJwwI6e6O0r3SAGHUnXrcD/SnjFr5GPL8XVHltV6mR3qimoegFQk=
X-Received: by 2002:a2e:ab0a:0:b0:37c:c84a:99b9 with SMTP id 38308e7fff4ca-38a8979cc5emr1066641fa.24.1773341120875;
        Thu, 12 Mar 2026 11:45:20 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e7b64bsm10382991fa.43.2026.03.12.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:45:20 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
Date: Thu, 12 Mar 2026 18:45:18 +0000
Message-Id: <20260312184520.24399-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__xbc_open_brace() pushes entries with post-increment
(open_brace[brace_index++]), so brace_index always points one past
the last valid entry.  xbc_verify_tree() reads open_brace[brace_index]
to report which brace is unclosed, but this is one past the last
pushed entry and contains stale/zero data, causing the error message
to reference the wrong node.

Use open_brace[brace_index - 1] to correctly identify the unclosed
brace.  brace_index is known to be > 0 here since we are inside the
if (brace_index) guard.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2bcd5c2aa87e..a1e6a2e14b01 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -802,7 +802,7 @@ static int __init xbc_verify_tree(void)
 
 	/* Brace closing */
 	if (brace_index) {
-		n = &xbc_nodes[open_brace[brace_index]];
+		n = &xbc_nodes[open_brace[brace_index - 1]];
 		return xbc_parse_error("Brace is not closed",
 					xbc_node_get_data(n));
 	}
-- 
2.34.1

