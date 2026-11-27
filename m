Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791087;
	b=fDcmYsBRQOzV6K4I7dUOHNwcQxJaXtXq/ue37G12Mu1TFGuP2TdkBzQ/DALT7PajmR3G
	 hot6b6sbiyIHTO2gl1dp8H3b3Ra8xzAnNfts/Az+JFtyoxcAbps+gv1jhOoOez7PEvLfe
	 n8rZdUtfu3uBAkXEzteSLle1Icz9DABgTo4gRcoMDeC/zXt6oYNUIzJW8/W1/PrUr6jxV
	 JxiTN6WtFHvmEFFbwSMg9A0rQsMsS+bku4Qcw7Ow9GRfW+4dntqOEeiwTAewEExGZ7Umk
	 cPEpLmIT5uECMR1xPFQlc74xrKU2IpU9fyM6QTv8falwRlQAn9i8oF300cK6889oDyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bh3RZXcb3uYbEKnqZcXYEq+hkSmhNaRpNyZW4NzrGuc=;
	b=jECZw9j7LrZPCtrHgKX35ifIMSscoffoMsut/OBn4uMCKznQvTcwk1AsZ4Kp/WTGOSBO
	 V4j2JNzfEsOkXb3rGIQqk1zJ97j5N2rXGj8AEItXBt3fgdDegqZc8LcqGGG3dmjdHLXA1
	 eRAPMxbR37iCuqP3Fob9GKTZ7Oku4MtWq9r6lBETP8KZ2/c25g40u/P92PCjLN+nUV/EV
	 AObKihL5WmUoiFDQMTqF9TbzuCpSKRa2M5L8vSAD9ZwdArYg8xfRuce9NeGMxuHrKb5/1
	 z9lD/0m+fh4pf4WE0Pn/He2A0nQbImNvd7hskGdMH8YxqEgi9rVPOS5dwVtHiNH5Ujw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEXoF2in;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182D1606A31E;
	Fri, 27 Nov 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEXoF2in
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6460B1F000C1;
	Fri, 27 Nov 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791086;
	bh=Bh3RZXcb3uYbEKnqZcXYEq+hkSmhNaRpNyZW4NzrGuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEXoF2incG1XHvl8MqpABgGD7FGK2TkTC/1uH3Y2pd3XBrg+J2yYOnSj4vlkPwcDL
	 09mKncfupNKxrCIr9CJ0QiTT+bMNIqs866nzSXMDbNmr/PqDq/pChKIfzDeao5BsLz
	 wdNzrZQ38HhV4KH9TNddJoGR0UA9Q3n7QvXVPvcTBYNtPYZ6bKDTxn067Vs7pi4Ns6
	 gekdWqpNqNat7eEcgQdzaOh9jGE7Y4adQcp3pStAAdkV0Ocl50X1IxxnvT5FXIBNUw
	 tCsPlbM0onKDVlMrDZOozS/NxoA0wCvsDH70anbyyf7uLZlJpqsmSebChR4qq5uVwN
	 Yi9XULd4y3ImQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: snambakam@microsoft.com, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 5/5] Documentation: bootconfig: Document multiple bootconfigs and selection
Date: Fri, 27 Nov 2026 14:46:19 +0000
Message-ID: <20261127144614.61194-6-mhiramat@kernel.org>
X-Mailer: UndineD 0.1
In-Reply-To: <20261127144614.61194-1-mhiramat@kernel.org>
References: <20261127144614.61194-1-mhiramat@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Document stacked initrd bootconfigs, #BOOTCONFIG-ID naming rules,
index 0 default semantics, XBC_CONFIG_MAX (32) limits, backward
compatibility and single-image requirements, bootconfig= command-line
selection syntax, updated CONFIG_CMDLINE_FROM_BOOTCONFIG selection
rules, and tools/bootconfig -i usage in
Documentation/admin-guide/bootconfig.rst.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst | 82 ++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 3d6412458c8b..72be0df4cb3d 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -199,11 +199,11 @@ to/from initrd image. You can build it by the following command::
  # make -C tools/bootconfig
 
 To add your boot config file to initrd image, run bootconfig as below
-(Old data is removed automatically if exists)::
+(Old default data is replaced if it exists)::
 
  # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
 
-To remove the config from the image, you can use -d option as below::
+To remove all boot config files from the image, use the -d option as below::
 
  # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
 
@@ -212,6 +212,69 @@ kernel to look for the bootconfig at the end of the initrd file.
 Alternatively, build your kernel with the ``CONFIG_BOOT_CONFIG_FORCE``
 Kconfig option selected.
 
+Attaching Multiple Boot Configs to Initrd
+-----------------------------------------
+
+Multiple bootconfig files (up to 32) can be stacked at the end of an initrd
+image, which is useful for Unified Kernel Images (UKIs) that bundle a base
+configuration alongside scenario-specific or debug overlays::
+
+ [initrd][block 0 (default)][block 1 (id1)][block 2 (id2)]...
+
+Each block has its own ``#BOOTCONFIG\n`` footer. Named blocks carry an
+in-band comment header on their first line (``#BOOTCONFIG-ID: <id>\n``).
+Identifiers must be 1 to 31 characters long, start with an ASCII letter or
+underscore (``[A-Za-z_]`` -- leading digits are reserved for 0-based indices),
+and contain only ASCII letters, digits, ``_``, ``-``, or ``.``.
+
+To attach or replace a named bootconfig, pass ``-i <id>`` to ``bootconfig``::
+
+ # tools/bootconfig/bootconfig -a base.bconf /boot/initrd.img-X.Y.Z
+ # tools/bootconfig/bootconfig -i debug -a debug.bconf /boot/initrd.img-X.Y.Z
+ # tools/bootconfig/bootconfig -i trace -a trace.bconf /boot/initrd.img-X.Y.Z
+
+To inspect or preview the merged result on the host, or selectively delete
+configs::
+
+ # tools/bootconfig/bootconfig /boot/initrd.img-X.Y.Z
+ # tools/bootconfig/bootconfig -l -i ,debug /boot/initrd.img-X.Y.Z
+ # tools/bootconfig/bootconfig -d -i debug /boot/initrd.img-X.Y.Z
+
+The block at index ``0`` is the default bootconfig. ``bootconfig -a`` without
+``-i`` always places the unnamed block at index ``0``; deleting index ``0``
+(``bootconfig -d -i 0``) promotes the next block to index ``0`` (making it the
+new default). At boot time, ``bootconfig`` parameters before ``--`` are
+evaluated left-to-right:
+
+- ``bootconfig`` (bare): selects only the default config (index ``0``).
+- ``bootconfig=id1,id2`` (or ``bootconfig=0,2``): selects and merges the
+  listed IDs or 0-based indices in initrd stack order. An empty entry such as
+  ``bootconfig=,debug`` is shorthand for ``0,debug``.
+- ``bootconfig=+debug``: appends ``debug`` onto an earlier ``bootconfig=...``
+  selection on the command line (or onto index ``0`` if no prior
+  ``bootconfig`` parameter appeared).
+- ``bootconfig=`` (empty value): clears earlier selections and loads no
+  bootconfig (unless ``CONFIG_BOOT_CONFIG_FORCE=y`` is set, which forces
+  index ``0`` when no config is selected).
+
+Selected configs are merged in stack order (index ``0`` first, later overlays
+after), so overlays can use ``:=`` and ``+=`` to override or extend base keys.
+
+.. warning::
+
+   - **Older kernels**: A kernel without multi-bootconfig support strips and
+     loads only the outermost trailer (the last overlay) as the sole
+     bootconfig, leaving earlier trailers inside the initrd where
+     ``unpack_to_rootfs()`` will fail with ``Initramfs unpacking failed`` (or
+     fall back to ``CONFIG_BLK_DEV_RAM``).
+   - **Older tools**: An older ``tools/bootconfig -a/-d`` operates only on the
+     outermost trailer and leaves earlier stacked blocks behind.
+   - **Single contiguous trailer stack**: Inner trailers must end at the exact
+     start of the next trailer with no inter-image padding. All stacked
+     bootconfig blocks must therefore be attached at the tail of a single
+     initrd image via ``tools/bootconfig -i`` rather than split across
+     separately padded initrd images or UKI initrd addons.
+
 Embedding a Boot Config into Kernel
 -----------------------------------
 
@@ -254,10 +317,12 @@ an architecture that selects ``CONFIG_ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG``.
 Currently only x86 selects it; on other architectures the embedded
 bootconfig still works, but only through the late runtime parser.
 
-The same ``bootconfig`` opt-in applies as elsewhere: the rendered keys
-are prepended only when ``bootconfig`` (in any form) appears on the
-kernel command line, or when ``CONFIG_BOOT_CONFIG_FORCE`` is set, which
-defaults to ``y`` when ``CONFIG_BOOT_CONFIG_EMBED`` is set.
+The same ``bootconfig`` selection rules apply as elsewhere: the rendered
+keys are prepended only when index 0 (or the embedded bootconfig's ID) is
+selected via ``bootconfig`` on the kernel command line, or when
+``CONFIG_BOOT_CONFIG_FORCE`` is set (which defaults to ``y`` when
+``CONFIG_BOOT_CONFIG_EMBED`` is set) and no active ``bootconfig=...``
+selection overrides it.
 
 For example, given::
 
@@ -367,6 +432,11 @@ the padding null characters.)
 Anyway, since bootconfig command verifies it when appending a boot config
 to initrd image, user can notice it before boot.
 
+When stacking multiple bootconfig files in an initrd, up to 32 files can be
+attached. Each individual file must fit within 32KB, while the combined size
+of all stacked files in the initrd may exceed 32KB as long as the subset
+selected at boot fits within 32KB and the node limit.
+
 
 Bootconfig APIs
 ===============
-- 
2.43.0

