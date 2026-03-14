Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA978388362;
	Sat, 14 Mar 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525344; cv=pass; b=u+LsW05SaQeLDiDWR+FwyZ5JNUqdjmmSFI2bEAzxgCmP+ABJtMQTQcMfvbxa14jIZJZ97mC+6xQFmKMHqQVVEuQ7uDYx3ci3waIISdv4ChJN8EpH6WQ68f8BC/Tv4zvJQFl3mqlIdw8STo6To71DdyN24IbuX93L0p4YZH7ddy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525344; c=relaxed/simple;
	bh=FXNMbqg55SqbPOuJegAqlqm+AJvfK6co4zCLBLrw5Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j37P8EcGk2JcCSJ3xQyqfqMJfXNYaVO/y5zZoSS8+24Zu1NbBH61zrzME9iKIdV+XNOMz1u71vNrW7AA3doXh4h23nwcDKavJjceXEPNW6vcMOsQqTXsoH68SQ5yUoEGOygPZfCtoc4NDKMdCHWVjy/DjltfLj9AaHgtjoQjTto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=MTahgRw0; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="MTahgRw0"
ARC-Seal: i=1; a=rsa-sha256; t=1773525335; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aj9ZibRqHmIfu74MF38s4SHS12mS7daAJZ3YWEUGQJk/NuWww075FD7cKzflxX2EBGpjVP5qvMdC0l4HDz0nnlRPZJKXY8dTdtyrKkvTZM6PYw2TTmCbhydXDbzjwoTUBoBlwprRwDd4aEQDGoKMieBPALHHJJQHo1o8biWns6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525335; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=; 
	b=hBu4zJjZt5HidUoQG+wyZUB/MnE9R6OYw8l30Sqyh3y+vE9smsnPBHGR4eRUiL+ip6yLjQqvR0NnnOEIlk8o6jrg1dfScuCDThZX28Wp5PsR6QONyo8NW972dYhXLnUITk7Mf2x3uV1bte4WJFJblsySEPR0AHV1p3ZsvmyL0Yw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525335;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=;
	b=MTahgRw0UItsXGkaj6TZA+6k3xmJ35LGHUdUu0O+8/X1AaDdPim5F6u0+dgy9A2u
	RNS/ZI9ML5bhTDhCH+Jg+QEmmlUsuw4mZW1++r/Eb1hMdr/PENQwcsRQk8Y7SBj/Ekp
	OpWtuWAEf0WtBi3OsivSm4+7dRtoSR4XizIsMN3U=
Received: by mx.zoho.eu with SMTPS id 1773525333683775.61190472551;
	Sat, 14 Mar 2026 22:55:33 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 11/14] bootconfig: use __packed macro for struct xbc_node
Date: Sat, 14 Mar 2026 21:55:23 +0000
Message-Id: <20260314215526.108651-12-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace the open-coded __attribute__((__packed__)) with the kernel
__packed macro for consistency with the rest of the kernel.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 25df9260d206..c37e0096c4f1 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -53,7 +53,7 @@ struct xbc_node {
 	uint16_t child;
 	uint16_t parent;
 	uint16_t data;
-} __attribute__ ((__packed__));
+} __packed;
 
 #define XBC_KEY		0
 #define XBC_VALUE	(1 << 15)
-- 
2.34.1

