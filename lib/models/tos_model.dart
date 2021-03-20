class TermsOfService {
  String tos;
  TermsOfService(this.tos);
}

List<TermsOfService> temporaryToS = tosSample
    .map((item) => TermsOfService(
          item['tos'],
        ))
    .toList();

var tosSample = [
  {
    "tos":
        "Please read these Terms of Use (Terms, Terms of Use) carefully before using the http://www.mywebsite.com (change this) website and the My Mobile App (change this) mobile application (the Service) operated by My Company (change this) (us, we, or our).Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service.PurchasesIf you wish to purchase any product or service made available through the Service (Purchase), you may be asked to supply certain information relevant to your Purchase including, without limitation, your …The Purchases section is for businesses that sell online (physical or digital). For the full disclosure section or for a “SaaS” section, create your own Terms of Use.TerminationWe may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.ContentOur Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material (Content). You are responsible for the …The Content section is for businesses that allow users to create, edit, share, make content on their websites or apps. For the full disclosure section, create your own Terms of Use.Links To Other Web SitesOur Service may contain links to third-party web sites or services that are not owned or controlled by My Company (change this).My Company (change this) has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that My Company (change this) shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services.ChangesWe reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 (change this) days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.Contact UsIf you have any questions about these Terms, please contact us.",
  },
];
