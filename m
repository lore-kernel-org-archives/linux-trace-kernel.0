Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DB17C9E;
	Tue, 11 Jun 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117374; cv=none; b=qDMhsUQBYdmo8c3MYk8JCSmbbyQREL8xb8VYK96YV6CMB0bM6NEwzNaw40rN43LdPmShkNW65qY+iQzw52nYUDi86E3xetfgtWFejYBfTxnAOrCbsZhNoXG4nxl2ZKnzBnIlB2j5Ey1mUeebDiHZIxHrhpcFi3c0YGTYcjI7dPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117374; c=relaxed/simple;
	bh=OpSqoPGOqKMo5eag5KgPTMflmJGctnG7QbWMhkWZzy0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kaJwd4Y8vOrlrJtmTzlIDKOGhQXtVjy8r60VgHNTBRyQEeR6dBpRFnDj83OOgK/oickOZ6Iqpu15sNrlhlJhudZFMlapK29AwBWAtQ8rZPs11q7T67kAownjIC1oyOKZc8ETX+COjAd3UrnEXmiiAYNp7rCVQHloW62BKIkQ0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55C8C4AF61;
	Tue, 11 Jun 2024 14:49:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH2on-00000001OoA-3XSY;
	Tue, 11 Jun 2024 10:49:49 -0400
Message-ID: <20240611144949.703297941@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 10:49:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
References: <20240611144911.327227285@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a method to find a region specified by reserve_mem=nn:align:name for
ramoops. Adding a kernel command line parameter:

  reserve_mem=12M:4096:oops ramoops.mem_name=oops

Will use the size and location defined by the memmap parameter where it
finds the memory and labels it "oops". The "oops" in the ramoops option
is used to search for it.

This allows for arbitrary RAM to be used for ramoops if it is known that
the memory is not cleared on kernel crashes or soft reboots.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20240606150316.916395285@goodmis.org

- Removed "built-in" from module description that was changed from v1.

 fs/pstore/ram.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..0653b76c70fe 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -50,6 +50,10 @@ module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
 		"start of reserved RAM used to store oops/panic logs");
 
+static char *mem_name;
+module_param_named(mem_name, mem_name, charp, 0400);
+MODULE_PARM_DESC(mem_name, "name of kernel param that holds addr");
+
 static ulong mem_size;
 module_param(mem_size, ulong, 0400);
 MODULE_PARM_DESC(mem_size,
@@ -914,6 +918,16 @@ static void __init ramoops_register_dummy(void)
 {
 	struct ramoops_platform_data pdata;
 
+	if (mem_name) {
+		unsigned long start;
+		unsigned long size;
+
+		if (reserve_mem_find_by_name(mem_name, &start, &size)) {
+			mem_address = start;
+			mem_size = size;
+		}
+	}
+
 	/*
 	 * Prepare a dummy platform data structure to carry the module
 	 * parameters. If mem_size isn't set, then there are no module
-- 
2.43.0


