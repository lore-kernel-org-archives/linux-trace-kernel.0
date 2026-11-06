Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009078;
	b=2aKNx/yWZur+TVpMYQtP39P85pkYwVDX8zE+d17MOAPcq8QQock+pnbUoo7gXFwJ7OOb
	 vCeU17Xyqc76mRLvElDhuopWl2eQGkKXIzY/jAoMqazSISms5w1lyhmIymLG4FrjtjeEs
	 GpW9x3PEUmRMnH/NAfZ0xzsFK8Z94+dKUqGfGZGwkpH1d0EHU5uH4YpBU73F+VUMazqqY
	 hqhjyoakgGOXGLVfNhvQLwEN2l+L+NzUdG8S2fhkO3vhac1G/jYl1jFF6ABxEifWu3T7X
	 HsbJW5Rc+Pnvb1/4+ARS5BZ9OK22bSKUaxC4Qp7GSJmusaOtd8XYE81sERKE8V5nXKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009078;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=htFkXyUAg99+8mwg8DQwhnbl55aL2EnLvZlSJCSC81E=;
	b=aDpuaNsL0/bqNZIxrLPoxwS22+lPLLAlLt05h4IdSmjHFuY052muYQsHWSernkzes38U
	 0ng1Lv8HyihpydbSBBfYLt6lTPRIlil9YdYa2oM707UMBZ+2XE/+fEhjr9SSTaUc29sTb
	 nMEOfa0+qkmQC2ItLEkJnHzz3zsuPuLxniFvR8ZBJJqZ8uIS0sOJbbPL4bV8WCQzpOFxG
	 tI3ozeF8lmTg2AQin26g0stDJeDuaKo5x/goIJzFbReEydKvJz2AMEhUgQDkWBOWcgYBz
	 MUu/rSN5B7LH5ijVb1iYg5Yas23bhSobk4P3UJVqYFRyJXVngmPTbHice4UslAqPFgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWJXqG4g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA9606A326;
	Fri,  6 Nov 2026 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWJXqG4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435D01F0089F;
	Fri,  6 Nov 2026 23:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794009078;
	bh=htFkXyUAg99+8mwg8DQwhnbl55aL2EnLvZlSJCSC81E=;
	h=From:Subject:Date:To:Cc;
	b=TWJXqG4gIBCeMZf/jPz6qGQyGhibhtlw2l6DAWV3+YLJa4wrkzZCIsrM2Hf5iKHOs
	 QTlkAGX5XF2cFmbBaHLxDihed8xcFGq7IvMkIKsYDHj5enrAiii57x3BUrI+nVkpdp
	 VOqh40QqQsDT6+1/RhnHVGmb1g2aD8dhUvAfccTmZtcfrHIywboGLqNbaQJ3EPSP3D
	 xf79xDYg4B7nJly7UqpkFrSLBz7HDP3mO6JlkJhJ01doS9hykZ+cA9e2Q6iru5ey0M
	 1IO6uOiGMDfwriPSehthK0uX5z6sUo+pOnzJ1swjWTzLCAeNH/m1ZOu33Gh4ojCbZo
	 vvikzXAmsbZCg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/2] mm/userfaultfd: prevent poison marker loss
Date: Sat, 07 Nov 2026 00:51:04 +0100
Message-Id: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOln7moC/yXMQQ6CMBBG4auQWdukbbQLrmIMgfIPDCqYGTEmh
 Ltbdfkt3tvIoAKjutpI8RKTZS4Ih4ry2M4DnPTFFH1MIfjkuqNbmfvm3uoV2twWM8eeTwk5xIx
 EpXwoWN6/6/nyt63dhPz8rmjfP5kX66B3AAAA
X-Change-ID: 20261106-b4-uffd_marker_loss-f0f56ec12ce6
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Peter Xu <peterx@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=david@kernel.org;
 h=from:subject:message-id; bh=yRPv7tjSRkmwFOuXv6HEv2HTp/IOs38MxUyLIMLVLl4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLepb9hOqd57p7K1jih09ufpB+5pN7m+uxPZWqp8u/W+
 +f+yuY96ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiK9cy/A9VP3mNb8PPqpaz
 hllHBa++/211Mb8u9Fj71X2Lmt7nno1gZDgyVy3nf9L0gmXLPy19FsM5W3ha9v2w5BvZxZkhYoc
 DN/ADAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Now that Lorenzo's atomic vma flag fixes are in, we can also use it
for userfaultfd POISON markers.

In patch #1, we use a new VM_MAYBE_UFFD_POISON to remember that we had
POISON markers installed by uffd. We then use that to fix marker
handling during fork(), during hugetlb PMD table sharing, and during
retract_page_tables().

In patch #2, we perform a similar rework to retract_page_tables()[1] that
we did to try_collapse_pte_mapped_thp(), to make the code simpler and
less error-prone.

Once review finished, I will take this through core.git, where it
depends on a related try_collapse_pte_mapped_thp() cleanup/fix.

This is not urgent, just something that should be fixed properly.

[1] https://lore.kernel.org/linux-mm/20261031-fixes_core-v3-18-d6437171ecc3@kernel.org/

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm/userfaultfd: prevent poison marker loss
      mm/khugepaged: check for empty PTE tables before retracting

 Documentation/filesystems/proc.rst |   1 +
 fs/proc/task_mmu.c                 |   3 +
 include/linux/mm.h                 |  45 ++++++++-----
 include/linux/userfaultfd_k.h      |   7 ++-
 include/trace/events/mmflags.h     |   9 ++-
 mm/Kconfig                         |   1 +
 mm/khugepaged.c                    | 126 +++++++++++++------------------------
 mm/userfaultfd.c                   |   3 +
 tools/testing/vma/include/dup.h    |  20 ++++--
 9 files changed, 110 insertions(+), 105 deletions(-)

---

base-commit: df3c65887715e66e2cba69116924020c37996cd8

change-id: 20261106-b4-uffd_marker_loss-f0f56ec12ce6

--

Cheers,

David

