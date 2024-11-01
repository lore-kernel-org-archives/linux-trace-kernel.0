Received: from msa.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE01E2828;
	Fri,  1 Nov 2024 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497748; cv=none; b=RViMq2I4+OezglbPpx+wG9JVYqPgWa2LYLNwDCRdUHX4qujAl1lAC70B5hN8JUZO/30BPyvnO0X7VJ+Nczqusws6K6GWEGz8rFrWU/4yYaawSnVq/nOeBYPdyfmoGjmRbAszihdOl8Np06u0Sp7cXe6jOzwtOx7dpoE28R68LCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497748; c=relaxed/simple;
	bh=lOOo4ZXdmdikkhGGJEt2LgdpZPz5E/NO8DC+U+ixe3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rpi7fOj2j4m8ygsEbfjl36nffmHsmQi0xUo7xp1bXQEkmID1XJCAWPOfExn/+AmW4uuP8tnrlb34O1tDYnGzCfRZSoSEqRhWwD3PjzVTIErVt7/Q9daS0ZKB9yLkr5olChFAKGw8B0pCeaMKuc/aeQNHsMZFnvKawi4O3tNmJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=h7g00QC+; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="h7g00QC+"
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 6yxjtTrloA7fH6yxktswpK; Fri, 01 Nov 2024 22:13:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730495625;
	bh=EYi+7zxC4m12VG02hrYZtY36xLPuD6WgT3l4MPN+hD4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=h7g00QC+zuN+TfEujN3s0xj8P9ecv5kWshswogVhEBqlPfZh/5/INCFkppQxLjtaK
	 J/yQKYKmTRBZ/+zEKj/SEqMKUCMBhs8diO8eXo8ZdhhGaspr1SGriH8XxBZgittLdM
	 JYjl4pMkaV3lDjm5FCfjJ52YL7lxfUU7Ns3TQ/chqT0TUnveQcZ5hLQS6Jc5TWBaid
	 jzH8KS/maKtrVap8iEYlvhwSXs36KaWLjtzF6+imsOyseL2lecsek6QevAiErLt8nF
	 +9z7IzsNJJIf5McHQAjPl1MjUcl5PlhHaUz3jL538KD8aWGhxHaO4W+KPyzB+vambK
	 GYv1+9O7lX8Hg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Nov 2024 22:13:45 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] uprobes: Re-order struct uprobe_task to save some space
Date: Fri,  1 Nov 2024 22:13:33 +0100
Message-ID: <a9f541d0cedf421f765c77a1fb93d6a979778a88.1730495562.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86_64, with allmodconfig, struct uprobe_task is 72 bytes long, with a
hole and some padding.

	/* size: 72, cachelines: 2, members: 7 */
	/* sum members: 64, holes: 1, sum holes: 4 */
	/* padding: 4 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
	/* last cacheline: 8 bytes */

Reorder the structure to fill the hole and avoid the padding.

This way, the whole structure fits in a single cacheline and some memory is
saved when it is allocated.

	/* size: 64, cachelines: 1, members: 7 */
	/* forced alignments: 1 */

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 include/linux/uprobes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index dbaf04189548..c684a470477f 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -73,6 +73,9 @@ enum uprobe_task_state {
 struct uprobe_task {
 	enum uprobe_task_state		state;
 
+	unsigned int			depth;
+	struct return_instance		*return_instances;
+
 	union {
 		struct {
 			struct arch_uprobe_task	autask;
@@ -89,9 +92,6 @@ struct uprobe_task {
 	unsigned long			xol_vaddr;
 
 	struct arch_uprobe              *auprobe;
-
-	struct return_instance		*return_instances;
-	unsigned int			depth;
 };
 
 struct return_consumer {
-- 
2.47.0

